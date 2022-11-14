import 'package:amond/domain/repositories/member_repository.dart';

class GetUserName {
 MemberRepository memberRepository;
  GetUserName(this.memberRepository);

  Future<String> call() async {
    final info = await memberRepository.getUserInfo();
    return info.userName;
  }
}