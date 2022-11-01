import 'dart:convert';

import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/utils/auth/auth_info.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:http/http.dart' as http;

class MemberApi {
  Future<http.Response> login(String provider, String accessToken) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(url,
        body:
            jsonEncode({"providerType": provider, "accessToken": accessToken}),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        }).timeout(const Duration(seconds: 6));
    print(response.body);
    return response;
  }

  Future<http.Response> resign(String provider,
      [Map<String, String>? additional]) async {
    final url = Uri.parse('$baseUrl/auth/withdraw');

    final Map<String, String> body = additional == null
        ? {
            'providerType': provider,
          }
        : {
            'providerType': provider,
            ...additional
          };
    
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
}
