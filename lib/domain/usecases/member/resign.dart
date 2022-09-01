import 'package:amond/data/entity/member_entity.dart';
import 'package:amond/domain/repositories/member_repository.dart';

class Resign {
  MemberRepository memberRepository;

  Resign(this.memberRepository);

  Future<int> call(MemberEntity me) async {
    return await memberRepository.resign(me);
  }
}