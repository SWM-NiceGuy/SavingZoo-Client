import 'package:amond/data/entity/member_entity.dart';
import 'package:amond/data/source/network/api/member_api.dart';
import 'package:amond/domain/repositories/member_repository.dart';

class MemberRepositoryImpl implements MemberRepository {
  MemberApi memberApi;

  MemberRepositoryImpl(this.memberApi);

  @override
  /// 회원가입 함수
  ///
  /// response의 statusCode를 반환 성공하면 200을 반환
  Future<int> signUp(MemberEntity me) async {
    final response =  await memberApi.signUp(me);
    return response.statusCode;
  }

}