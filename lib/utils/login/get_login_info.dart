abstract class GetLoginInfo {
  Future<LoginInfo> call();
}

class LoginInfo {
  final String provider;
  final String accessToken;

  LoginInfo(this.provider, this.accessToken);
}