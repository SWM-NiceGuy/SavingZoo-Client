import 'package:amond/domain/repositories/member_repository.dart';

class ChangeUserName {
  MemberRepository memberRepository;
  ChangeUserName(this.memberRepository);

  Future<void> call(String name) async {
    await memberRepository.changeUserName(name);
  }
}