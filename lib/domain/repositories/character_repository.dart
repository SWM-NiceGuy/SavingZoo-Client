import 'package:amond/data/entity/member_entity.dart';
import 'package:amond/domain/models/member_info.dart';

abstract class CharacterRepository {
  Future<int> getExp(String provider, String uid);
  Future<int> changeExp(String provider, String uid, int exp);
  Future<String> getName(MemberInfo me);
  Future<void> setName(MemberInfo me, String name);
}