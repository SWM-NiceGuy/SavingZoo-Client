import 'package:amond/data/entity/member_entity.dart';
import 'package:amond/domain/repositories/member_repository.dart';

class MemberUseCases {
  MemberRepository repository;
  MemberUseCases(this.repository);

  Future<int> signUp(MemberEntity me) async {
    final statusCode = await repository.signUp(me);
    return statusCode;
  }
 }