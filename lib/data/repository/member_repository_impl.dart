import 'dart:convert';

import 'package:amond/data/source/network/api/member_api.dart';
import 'package:amond/domain/repositories/member_repository.dart';

class MemberRepositoryImpl implements MemberRepository {
  MemberApi memberApi;

  MemberRepositoryImpl(this.memberApi);

  @override
  /// DB 회원가입 함수
  ///
  /// response의 json web token을 반환
  Future<String> login(String provider, String accessToken) async {
    final response =  await memberApi.login(provider, accessToken);
    final token = jsonDecode(response.body)["jwt"];
    return token;
  }
  
  @override
  /// DB 회원탈퇴 함수
  /// 
  /// response의 statusCode를 반환 성공하면 200을 반환
  Future<void> resign(String provider, [Map<String, String>? additional]) async {
    await memberApi.resign(provider, additional);
  }
  
  @override
  Future<String> getUserName() {
    // TODO: implement getUserName
    throw UnimplementedError();
  }
  
  @override
  Future<void> changeUserName(String name) {
    // TODO: implement changeUserName
    throw UnimplementedError();
  }
}
