import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';

class AuthController with ChangeNotifier {
  OAuthToken? _token;

  AuthController() {
    _setToken();
  }

  OAuthToken? get token => _token;

  bool get isTokenExists => _token != null;

  Future<bool> _isTokenValid() async {
    if (await AuthApi.instance.hasToken()) {
      try {
        // 토큰 유효성 체크 성공
        AccessTokenInfo? tokenInfo = await UserApi.instance.accessTokenInfo();
        return true;
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          // print('토큰 만료 $error');
        } else {
          // print('토큰 정보 조회 실패 $error');
        }
      }
    }
    return false;
  }

  Future<void> loginWithKakaoApp() async {
    // 카카오톡 설치 여부 확인
    // 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        // print('카카오톡으로 로그인 성공');
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

  Future<void> _setToken() async {
    if (await _isTokenValid()) {
      _token = await TokenManagerProvider.instance.manager.getToken();
    }
  }
}
