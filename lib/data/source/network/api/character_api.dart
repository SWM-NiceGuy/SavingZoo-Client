import 'dart:convert';

import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/domain/models/member_info.dart';
import 'package:http/http.dart' as http;

class CharacterApi {
  Future<int> getExp(String provider, String uid) async {
    try {
    final url = Uri.parse('$baseUrl/v1/exp?provider=$provider&uid=$uid');
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      throw Exception('경험치 불러오기에 실패했습니다.');
    }
    final res = jsonDecode(response.body)['exp'];
    return res;
    } catch (error) {
      rethrow;
    }
  }

  Future<int> changeExp(String provider, String uid, int exp) async {
    final url = Uri.parse('$baseUrl/v1/exp');
    
    final response = await http.put(
      url,
      body: jsonEncode({
        'provider': provider,
        'uid': uid,
        'exp': exp,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    final res = jsonDecode(response.body)['exp'];
    return res;
  }

  Future<String?> getName(MemberInfo me) async {
    final url = Uri.parse('$baseUrl/v1/nickname?provider=${me.provider}&uid=${me.uid}');

    final response = await http.get(url);
    final String? res = jsonDecode(response.body)["nickname"];
    return res;
  }

  Future<void> setName(MemberInfo me, String name) async {
    final url = Uri.parse("$baseUrl/v1/nickname");
    
    final response = await http.post(url, body: jsonEncode({
      "provider": me.provider,
      "uid": me.uid,
      "nickname": name,
    }),  headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },);
  }
}
