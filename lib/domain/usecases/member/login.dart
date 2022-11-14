import 'package:amond/domain/repositories/member_repository.dart';
import 'package:amond/utils/auth/do_auth.dart';

class Login {
  MemberRepository memberRepository;
  Login(this.memberRepository);

  Future<Map<String, dynamic>> call(LoginInfo info) async {
    final result = await memberRepository.login(info);
    return result;
  }
}