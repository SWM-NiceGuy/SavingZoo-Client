
import 'package:amond/domain/models/user_info.dart';
import 'package:amond/utils/auth/do_auth.dart';

abstract class MemberRepository {
  Future<Map<String, dynamic>> login(LoginInfo info);
  Future<void> resign(String provider, [Map<String, String>? additional]);
  Future<UserInfo> getUserInfo();
  Future<void> changeUserName(String name);
}
