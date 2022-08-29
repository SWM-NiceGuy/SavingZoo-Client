import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginType { kakao, apple }

class AuthController with ChangeNotifier {
  String? _accessToken;
  LoginType? _loginType;
  SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  String? get token => _accessToken;
  bool get isTokenExists => _accessToken != null;

  /// 앱 시작시 토큰 설정 (자동로그인)
  /// 
  /// 토큰 설정이 성공하면 [true]를 반환
  /// 실패하면 [false]를 반환
  Future<bool> setToken() async {
    final prefs = await this.prefs;
    _loginType = _getLoginTypeFromString(prefs.getString('loginType'));
    if (_loginType == null) return false;

    if (_loginType == LoginType.kakao) {
      final token = await TokenManagerProvider.instance.manager.getToken();
      _accessToken = token?.accessToken;
    } else if (_loginType == LoginType.apple) {
      _accessToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    }
    return true;
  }

  /// 토큰 유효성 검사
  Future<bool> isTokenValid() async {
    if (_loginType == null) return false;

    if (_loginType == LoginType.kakao) {
      // 카카오 로그인일때
      if (await AuthApi.instance.hasToken()) {
        try {
          // 토큰 유효성 체크 성공
          AccessTokenInfo? tokenInfo = await UserApi.instance.accessTokenInfo();
          return true;
        } catch (error) {
          if (error is KakaoException && error.isInvalidTokenError()) {
            // print('토큰 만료 $error');
            rethrow;
          } else {
            // print('토큰 정보 조회 실패 $error');
            rethrow;
          }
        }
      }
    } else if (_loginType == LoginType.apple) {
      // 애플 로그인일때
      _accessToken = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (_accessToken == null) return false;
      return true;
    }
    return false;
  }

  /// 카카오로 로그인
  Future<void> loginWithKakaoApp() async {
    final prefs = await this.prefs;
    // 카카오톡 설치 여부 확인
    // 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        // print('카카오톡으로 로그인 성공');
        await prefs.setString('loginType', 'kakao');
        await setToken();
      } catch (error) {
        // print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          rethrow;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          // print('카카오계정으로 로그인 성공');
        } catch (error) {
          // print('카카오계정으로 로그인 실패 $error');
          rethrow;
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        // print('카카오계정으로 로그인 성공');
      } catch (error) {
        // print('카카오계정으로 로그인 실패 $error');
        rethrow;
      }
    }
  }

  /// 애플로 로그인
  Future<void> loginWithApple() async {
    final prefs = await this.prefs;
    try {
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      // print('애플로 로그인 성공');
      await prefs.setString('loginType', 'apple');
      await setToken();
      // print(authResult);
      return Future<void>.value();
    } catch (error) {
      // print('애플 로그인 실패 $error');
      rethrow;
    }
  }

  LoginType? _getLoginTypeFromString(String? str) {
    if (str == null) return null;
    switch (str) {
      case 'kakao':
        return LoginType.kakao;
      case 'apple':
        return LoginType.apple;
    }
    return null;
  }

  /// 로그아웃 함수
  ///
  /// 카카오톡은 SDK에서 토큰삭제
  ///
  /// 애플은 currentUser를 null로 바꿔서 로그아웃
  Future<void> logout() async {
    final prefs = await this.prefs;

    if (_loginType == LoginType.kakao) {
      try {
        await UserApi.instance.logout();
        // print('카카오 로그아웃 성공, SDK에서 토큰 삭제');
        _accessToken = null;
        await prefs.remove('loginType');
      } catch (error) {
        rethrow;
      }
    } else if (_loginType == LoginType.apple) {
      try {
        await FirebaseAuth.instance.signOut();
        // print('애플 로그아웃 성공');
        _accessToken = null;
        await prefs.remove('loginType');
      } catch (error) {
        // print('애플 로그아웃 실패 $error');
        rethrow;
      }
    }
  }
}
