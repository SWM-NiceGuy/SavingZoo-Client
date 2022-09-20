import 'package:amond/domain/repositories/member_repository.dart';

class SignUp {
  MemberRepository memberRepository;

  SignUp(this.memberRepository);

  Future<String> call(String provider, String accessToken) async {
    return memberRepository.signUp(provider, accessToken);
  }
}