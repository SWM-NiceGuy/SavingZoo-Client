

abstract class DoAuth {
  Future<LoginInfo> login();
  Future<Map<String,String>?> resign();
}

class LoginInfo {
  final String provider;
  final String accessToken;
  final String? username;

  LoginInfo({required this.provider, required this.accessToken, this.username});
}