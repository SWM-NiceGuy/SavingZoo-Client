import 'package:amond/data/entity/member_entity.dart';

abstract class MemberRepository {
  Future<String> signUp(String provider, String accessToken);
  Future<int> resign(MemberEntity me);
}