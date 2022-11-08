import 'package:amond/domain/repositories/member_repository.dart';
import 'package:amond/utils/auth/do_auth.dart';

class Login {
  MemberRepository memberRepository;
  Login(this.memberRepository);

  Future<String> call(LoginInfo info) async {
    final token = await memberRepository.login(info);
    return token;
  }
}