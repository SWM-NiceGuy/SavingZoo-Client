import 'package:amond/domain/repositories/member_repository.dart';

class Login {
  MemberRepository memberRepository;
  Login(this.memberRepository);

  Future<String> call(String provider, String accessToken) async {
    final token = await memberRepository.login(provider, accessToken);
    return token;
  }
}