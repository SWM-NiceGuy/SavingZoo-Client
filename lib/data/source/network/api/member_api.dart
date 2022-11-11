import 'dart:convert';

import 'package:amond/data/entity/user_info_entity.dart';
import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/utils/auth/auth_info.dart';
import 'package:amond/utils/auth/do_auth.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:http/http.dart' as http;

class MemberApi {
  Future<Map<String,dynamic>> login(LoginInfo info) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      body: jsonEncode({"providerType": info.provider, "accessToken": info.accessToken, "username": info.username}),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    ).timeout(const Duration(seconds: 6));
    
    if (kDebugMode) {
      print('로그인 응답: ${response.body} \n(code:${response.statusCode})');
    }

    final token = jsonDecode(response.body)["jwt"];

    return {'token':token, 'statusCode': response.statusCode};
  }

  Future<http.Response> resign(String provider,
      [Map<String, String>? additional]) async {
    final url = Uri.parse('$baseUrl/auth/withdraw');

    final Map<String, String> body = additional == null
        ? {
            'providerType': provider,
          }
        : {'providerType': provider, ...additional};

    try {
      final response = await http.delete(url, body: jsonEncode(body), headers: {
        'Authorization': 'Bearer $globalToken',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      if (kDebugMode) {
        print('회원탈퇴 응답 : ${response.body}');
      }
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<UserInfoEntity> getUserInfo() async {
    final url = Uri.parse('$baseUrl/user/info');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $globalToken',
        'Accept': 'application/json',
      },
    );
    final Map<String, dynamic> json =
        jsonDecode(utf8.decode(response.bodyBytes));
    final info = UserInfoEntity.fromJson(json);
    return info;
  }

  Future<void> changeUserName(String name) async {
    final url = Uri.parse('$baseUrl/user/info');
    await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $globalToken',
        'Accept': 'application/json',
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        'username': name,
      })
    );
  }
}
