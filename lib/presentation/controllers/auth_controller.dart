import 'dart:convert';

import 'package:amond/data/entity/member_entity.dart';
import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/domain/usecases/member/member_use_cases.dart';
import 'package:amond/utils/apple_client_secret.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../domain/models/member_info.dart';

enum LoginType { kakao, apple }

class AuthController with ChangeNotifier {
  MemberInfo? _memberInfo;
  String? _token;
  SharedPreferences? _prefs;
  final MemberUseCases _memberUseCases;

  String? get token => _token;

  AuthController(this._memberUseCases);

  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  MemberInfo? get memberInfo => _memberInfo;
  bool get isTokenExists => _memberInfo != null;

  /// 앱 시작시 토큰 설정 (자동로그인)
  ///
  /// 토큰 설정이 성공하면 [true]를 반환
  /// 실패하면 [false]를 반환
  Future<bool> setToken() async {
    final prefs = await this.prefs;
  try {
    final token = prefs.getString("jwt");
    _token = token;
    // 전역으로 토큰 설정

    jwt = _token;
    // 토큰이 없다면 [false] 반환
    if (_token == null) {
      return false;
    }
    
  } catch (error) {
    rethrow;
  }
    notifyListeners();
    return true;
  }

  // /// 토큰 유효성 검사
  // Future<bool> isTokenValid() async {
  //   final prefs = await this.prefs;
  //   final loginType = _getLoginTypeFromString(prefs.getString("loginType"));
  //   if (loginType == null) return false;

  //   // 카카오
  //   if (loginType == LoginType.kakao) {
  //     if (await AuthApi.instance.hasToken()) {
  //       try {
  //         await UserApi.instance.accessTokenInfo();
  //         // 토큰 유효성 체크 성공
  //         return true;
  //       } catch (error) {
  //         if (error is KakaoException && error.isInvalidTokenError()) {
  //           // print('토큰 만료 $error');
  //           rethrow;
  //         } else {
  //           // print('토큰 정보 조회 실패 $error');
  //           rethrow;
  //         }
  //       }
  //     }
  //   }

  //   // 애플
  //   else if (loginType == LoginType.apple) {
  //     await FirebaseAuth.instance.currentUser?.getIdToken();
  //     return true;
  //   }
  //   return false;
  // }

  /// 카카오로 로그인
  Future<void> loginWithKakaoApp() async {
    final prefs = await this.prefs;
    // 카카오톡 설치 여부 확인
    // 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        // print('카카오톡으로 로그인 성공');

        // 카카오 계정 토큰 정보
        final tokenInfo = await TokenManagerProvider.instance.manager.getToken();
        final curToken = tokenInfo!.accessToken;


        final jwt = await _memberUseCases.signUp("KAKAO", curToken);
        await prefs.setString('loginType', 'kakao');
        // jwt 저장
        await prefs.setString('jwt', jwt);
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
          // 카카오 계정으로 처음 로그인하면
          // 카카오 계정 토큰 정보
        final tokenInfo = await TokenManagerProvider.instance.manager.getToken();
        final curToken = tokenInfo!.accessToken;


        final jwt = await _memberUseCases.signUp("KAKAO", curToken);
        await prefs.setString('loginType', 'kakao');
        // jwt 저장
        await prefs.setString('jwt', jwt);
        await setToken();
        } catch (error) {
          // print('카카오계정으로 로그인 실패 $error');
          rethrow;
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        // print('카카오계정으로 로그인 성공');

        // 카카오 계정으로 처음 로그인하면
       // 카카오 계정 토큰 정보
        final tokenInfo = await TokenManagerProvider.instance.manager.getToken();
        final curToken = tokenInfo!.accessToken;


        final jwt = await _memberUseCases.signUp("KAKAO", curToken);
        await prefs.setString('loginType', 'kakao');
        // jwt 저장
        await prefs.setString('jwt', jwt);
        await setToken();
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

      // final oauthCredential = OAuthProvider("apple.com").credential(
      //   idToken: appleCredential.identityToken,
      //   accessToken: appleCredential.authorizationCode,
      // );

      // Apple로그인을 통해 받은 정보로 파이어베이스에 로그인
      // await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      // App 내의 로그인/회원가입 로직
      final token = await _memberUseCases.signUp('APPLE', appleCredential.identityToken!);

      await prefs.setString('jwt', token);
      await setToken();
    } catch (error) {
      // print('애플 로그인 실패 $error');
      rethrow;
    }
  }

  /// SharedPreferences에서 가져온 loginType의 [String]값을 [LoginType]으로 변환하여 반환
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
  /// [SharedPreferences.getInstance()]에 저장되어 있는 jwt 삭제
  Future<void> logout() async {
    final prefs = await this.prefs;
    try {
        await prefs.remove('jwt');
      } catch (error) {
        // print('로그아웃 실패 $error');
        rethrow;
      }
    }

  /// 회원 탈퇴 함수
  ///
  /// 카카오는 자체 skd의 [UserApi.instance.unlink] 함수를 호출
  /// 애플은 [FirebaseAuth.instance.currentUser?.delete] 함수를 호출
  ///
  /// 각각 회원 탈퇴후 sharedPreferences에서 login정보를 제거
  Future<void> resign() async {
    final prefs = await this.prefs;
    final loginType = _getLoginTypeFromString(prefs.getString("loginType"));
    if (loginType == LoginType.kakao) {
      try {
        await UserApi.instance.unlink();
        // print('카카오 탈퇴 성공, SDK에서 토큰 삭제');
        await _memberUseCases.resign(MemberEntity(
          provider: memberInfo!.provider,
          uid: memberInfo!.uid
        ));
        await prefs.remove('jwt');
      } catch (error) {
        // print('연결 끊기 실패 $error');
        rethrow;
      }
    } else if (loginType == LoginType.apple) {
      try {
        // revoke Endpoint
        Uri revokeUri = Uri.parse('https://appleid.apple.com/auth/revoke');
        Uri tokenUri = Uri.parse('https://appleid.apple.com/auth/token');

        // 애플 로그인 재진행우 Authorization code 재발급
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

        await FirebaseAuth.instance.signOut();
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);

        // Access Token 가져오기
        final atResponse = await http.post(tokenUri, body: {
          'client_id': 'com.amond.amondApp',
          'code': appleCredential.authorizationCode,
          'client_secret': Utils.appleClientSecret(),
          'grant_type': 'authorization_code'
        });
        final accessToken = jsonDecode(atResponse.body)['access_token'];

        // 가져온 Access Token으로 Revoke 시도
        final response = await http.post(revokeUri, body: {
          'client_id': 'com.amond.amondApp',
          'client_secret': Utils.appleClientSecret(),
          'token': accessToken,
        });

        // Revoke api 프로세스가 실패하면 에러 발생
        if (response.statusCode >= 400) {
          throw Exception('Revoke Failed');
        }

        await _memberUseCases.resign(MemberEntity(
          provider: memberInfo!.provider,
          uid: memberInfo!.uid
        ));

        await FirebaseAuth.instance.currentUser?.delete();
        await prefs.remove('loginType');
      } catch (error) {
        // print('애플 탈퇴 실패 $error');
        rethrow;
      }
    }
    _memberInfo = null;
  }
}
