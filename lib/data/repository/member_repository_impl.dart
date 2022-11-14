import 'package:amond/data/source/network/api/member_api.dart';
import 'package:amond/domain/models/user_info.dart';
import 'package:amond/domain/repositories/member_repository.dart';
import 'package:amond/utils/auth/do_auth.dart';

class MemberRepositoryImpl implements MemberRepository {
  MemberApi memberApi;

  MemberRepositoryImpl(this.memberApi);

  @override
  /// DB 회원가입 함수
  ///
  /// response의 json web token 및 status code 반환
  /// 
  /// status code가 201이면 신규유저 200이면 기존유저
  Future<Map<String, dynamic>> login(LoginInfo info) async {
    final response =  await memberApi.login(info);
    return response;
  }
  
  @override
  /// DB 회원탈퇴 함수
  /// 
  /// response의 statusCode를 반환 성공하면 200을 반환
  Future<void> resign(String provider, [Map<String, String>? additional]) async {
    await memberApi.resign(provider, additional);
  }
  
  @override
  Future<UserInfo> getUserInfo() async {
    final entity = await memberApi.getUserInfo();
    return UserInfo.fromEntity(entity);
  }
  
  @override
  Future<void> changeUserName(String name) async {
    await memberApi.changeUserName(name);
  }
}
