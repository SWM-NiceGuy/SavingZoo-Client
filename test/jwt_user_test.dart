import 'dart:convert';

import 'package:test/test.dart';
import 'package:http/http.dart' as http;

String token = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiYXV0aCI6IlJPTEVfVVNFUiIsImV4cCI6MTY2MzkzNzA3N30.hxyWEzl5xcxmg70qgWsFJeZTlc1zmF1pTLIkvIwSxvHqzzd1Y-jC3U2BuvjGjoHuxPtnMUv3WOPIeyCRo5osqA';
String baseUrl = 'http://3.39.252.210:8080';

void main() {
  test('user 정보를 잘 가져와야한다.', () async {
    final url = Uri.parse('$baseUrl/api/v1/user');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    expect(responseBody["email"], equals('knj2@kakao.com'));
  });
}