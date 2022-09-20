import 'dart:convert';

import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/domain/models/member_info.dart';
import 'package:http/http.dart' as http;

class CharacterApi {
  Future<int> getExp() async {
    try {
    final url = Uri.parse('$baseUrl/v1/exp');
    final response = await http.get(url, headers: {
      'Authrozation': 'Bearer $jwt',
    });
    if (response.statusCode >= 400) {
      throw Exception('경험치 불러오기에 실패했습니다.');
    }
    final res = jsonDecode(response.body)['exp'];
    return res;
    } catch (error) {
      rethrow;
    }
  }

  Future<int> changeExp(int exp) async {
    final url = Uri.parse('$baseUrl/v1/exp');
    
    final response = await http.put(
      url,
      body: jsonEncode({
        'exp': exp,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );
    final res = jsonDecode(response.body)['exp'];
    return res;
  }

  Future<String?> getName() async {
    final url = Uri.parse('$baseUrl/v1/nickname');

    final response = await http.get(url, headers: {
      'Authorization': '$jwt',
    });
    final String? res = jsonDecode(utf8.decode(response.bodyBytes))["nickname"];
    return res;
  }

  Future<void> setName(String name) async {
    final url = Uri.parse("$baseUrl/v1/nickname");
    
    final response = await http.post(url, body: jsonEncode({
      "nickname": name,
    }),  headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$jwt',
      },);
  }
}
