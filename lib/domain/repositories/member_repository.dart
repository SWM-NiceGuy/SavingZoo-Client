import 'package:amond/data/entity/member_entity.dart';

abstract class MemberRepository {
  Future<int> signUp(MemberEntity me);
}