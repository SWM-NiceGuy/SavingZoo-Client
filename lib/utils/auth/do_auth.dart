import 'package:shared_preferences/shared_preferences.dart';

abstract class DoAuth {
  Future<LoginInfo> login();
  Future<Map<String,String>?> resign();
}

class LoginInfo {
  final String provider;
  final String accessToken;

  LoginInfo(this.provider, this.accessToken);
}