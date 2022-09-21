import 'package:amond/utils/login/get_login_info.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class GetKakaoLoginInfo implements GetLoginInfo {
  @override
  Future<LoginInfo> call() async {
    late final String token;
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        // print('카카오톡으로 로그인 성공');

        // 카카오 계정 토큰 정보
        final tokenInfo = await TokenManagerProvider.instance.manager.getToken();
        token = tokenInfo!.accessToken;
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
        token = tokenInfo!.accessToken;
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
        token = tokenInfo!.accessToken;
      } catch (error) {
        // print('카카오계정으로 로그인 실패 $error');
        rethrow;
      }
    }

    return LoginInfo("KAKAO", token);
  }

}