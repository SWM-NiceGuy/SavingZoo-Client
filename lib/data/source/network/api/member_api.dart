import 'dart:convert';

import 'package:amond/utils/auth/auth_info.dart';
import 'package:http/http.dart' as http;

String baseUrl = 'http://3.39.252.210:8080';

class MemberApi {
  Future<http.Response> login(String provider, String accessToken) async {
    final url = Uri.parse('$baseUrl/api/v1/auth/login');
    final response = await http.post(url,
        body:
            jsonEncode({"providerType": provider, "accessToken": accessToken}),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
    return response;
  }

  Future<http.Response> resign(String provider,
      [Map<String, String>? additional]) async {
    final url = Uri.parse('$baseUrl/api/v1/auth/withdraw');

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
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
