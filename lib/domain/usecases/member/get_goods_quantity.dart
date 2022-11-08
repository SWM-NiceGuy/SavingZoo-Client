import 'package:amond/domain/repositories/member_repository.dart';

class GetGoodsQuantity {
  MemberRepository memberRepository;
  GetGoodsQuantity(this.memberRepository);

  Future<int> call() async {
    final info = await memberRepository.getUserInfo();
    return info.goodsQuantity;
  }
}