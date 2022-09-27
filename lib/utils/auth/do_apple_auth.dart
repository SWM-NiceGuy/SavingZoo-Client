import 'package:amond/utils/auth/do_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class DoAppleAuth implements DoAuth {
  @override
  Future<LoginInfo> login() async {
    try {
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      return LoginInfo("APPLE", appleCredential.identityToken!);
    } catch (error) {
      // print('애플 로그인 실패 $error');
      rethrow;
    }
  }

  @override
  Future<Map<String,String>?> resign() async {
    try {
      // revoke Endpoint

      // 애플 로그인 재진행우 Authorization code 재발급
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      return <String, String>{
        'authorizationCode': appleCredential.authorizationCode
      };
    } catch (error) {
      // print('애플 탈퇴 실패 $error');
      rethrow;
    }
  }
}
