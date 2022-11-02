import 'package:amond/domain/repositories/member_repository.dart';

class GetUserName {
 MemberRepository memberRepository;
  GetUserName(this.memberRepository);

  Future<String> call() async {
    final name = await memberRepository.getUserName();
    return name;
  }
}