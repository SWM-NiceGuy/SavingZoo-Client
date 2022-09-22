import 'package:amond/domain/repositories/member_repository.dart';

class Resign {
  MemberRepository memberRepository;

  Resign(this.memberRepository);

  Future<void> call(String provider, [Map<String, String>? additional]) async {
    await memberRepository.resign(provider, additional);
  }
}