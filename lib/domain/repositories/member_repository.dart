
import 'package:amond/domain/models/user_info.dart';

abstract class MemberRepository {
  Future<String> login(String provider, String accessToken);
  Future<void> resign(String provider, [Map<String, String>? additional]);
  Future<UserInfo> getUserInfo();
  Future<void> changeUserName(String name);
}
