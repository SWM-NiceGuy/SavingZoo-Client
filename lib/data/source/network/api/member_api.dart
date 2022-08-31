import 'dart:convert';

import 'package:amond/data/entity/member_entity.dart';
import 'package:amond/data/source/network/base_url.dart';
import 'package:http/http.dart' as http;

class MemberApi {
  Future<http.Response> signUp(MemberEntity me) async {
    final url = Uri.parse('$baseUrl/v1/signin');
    final response = await http.post(url, body: jsonEncode(me.toJson()), headers: {
  'Content-type' : 'application/json', 
  'Accept': 'application/json',
});
    return response;
  }

  
}
