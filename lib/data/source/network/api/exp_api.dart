import 'dart:convert';

import 'package:amond/data/source/network/base_url.dart';
import 'package:http/http.dart' as http;

class ExpApi {
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

  Future<int> getMissionCompleted(String provider, String uid) async {
    final url = Uri.parse('$baseUrl/v1/mission?provider=$provider&uid=$uid');
    final response = await http.get(url);
    final missionResult = jsonDecode(response.body)['mission'];
    return missionResult;
  }

  Future<void> changeMissionCompleted(String provider, String uid, int value) async {
    final url = Uri.parse('$baseUrl/v1/mission');
    final response = await http.put(
      url,
      body: jsonEncode({
        'provider': provider,
        'uid': uid,
        'mission': value,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }
}
