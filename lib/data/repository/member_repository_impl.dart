import 'dart:convert';

import 'package:amond/data/entity/member_entity.dart';
import 'package:amond/data/source/network/api/member_api.dart';
import 'package:amond/domain/repositories/member_repository.dart';

class MemberRepositoryImpl implements MemberRepository {
  MemberApi memberApi;

  MemberRepositoryImpl(this.memberApi);

  @override
  /// DB 회원가입 함수
  ///
  /// response의 json web token을 반환
  Future<String> signUp(String provider, String accessToken) async {
    final response =  await memberApi.signUp(provider, accessToken);
    final token = jsonDecode(response.body)["jwt"];
    return token;
  }
  
  @override
  /// DB 회원탈퇴 함수
  /// 
  /// response의 statusCode를 반환 성공하면 200을 반환
  Future<int> resign(MemberEntity me) async {
    final response = await memberApi.resign(me);
    return response.statusCode;
  }
}