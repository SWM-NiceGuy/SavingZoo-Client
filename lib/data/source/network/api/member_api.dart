import 'dart:convert';

import 'package:amond/data/entity/member_entity.dart';
import 'package:amond/data/source/network/base_url.dart';
import 'package:http/http.dart' as http;

class MemberApi {
  Future<http.Response> signUp(MemberEntity me) async {
    final url = Uri.parse('$baseUrl/v1/signup');
    final response =
        await http.post(url, body: jsonEncode(me.toJson()), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    return response;
  }

  Future<http.Response> resign(MemberEntity me) async {
    final url = Uri.parse('$baseUrl/v1/withdraw');
    final response = await http.delete(url, body: jsonEncode({
      'provider': me.provider,
      'uid': me.uid,
    }), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    return response;
  }
}
