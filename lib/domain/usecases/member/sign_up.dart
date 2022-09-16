import 'package:amond/data/entity/member_entity.dart';
import 'package:amond/domain/repositories/member_repository.dart';

class SignUp {
  MemberRepository memberRepository;

  SignUp(this.memberRepository);

  Future<int> call(MemberEntity me) async {
    return memberRepository.signUp(me);
  }
}