abstract class DoAuth {
  Future<LoginInfo> login();
  Future<Map<String,String>?> resign();
}

class LoginInfo {
  final String provider;
  final String accessToken;

  LoginInfo(this.provider, this.accessToken);
}