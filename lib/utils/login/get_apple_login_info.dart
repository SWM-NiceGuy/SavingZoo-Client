import 'package:amond/utils/login/get_login_info.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class GetAppleLoginInfo implements GetLoginInfo {
  @override
  Future<LoginInfo> call() async {
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

}