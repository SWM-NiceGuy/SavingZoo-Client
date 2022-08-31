import 'dart:convert';

import 'package:amond/data/source/network/base_url.dart';
import 'package:http/http.dart' as http;

class ExpApi {
  Future<int> getExp(String provider, String uid) async {
    final url = Uri.parse('$baseUrl/v1/exp?provider=$provider&uid=$uid');
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      throw Exception('경험치 불러오기에 실패했습니다.');
    }
    final res = jsonDecode(response.body)['exp'];
    return res;
  }

  Future<int> changeExp(String provider, String uid, int exp) async {
    final url = Uri.parse('$baseUrl/v1/exp');
    
    final response = await http.post(
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
}
