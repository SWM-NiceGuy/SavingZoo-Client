import 'dart:convert';

import 'package:amond/data/entity/banner_info_entity.dart';
import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/utils/auth/auth_info.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:http/http.dart' as http;

class BannerApi {
  Future<List<BannerInfoEntity>> getBannerInfo() async {
    final url = Uri.parse('$baseUrl/banners');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $globalToken',
      'Content-type': 'application/json',
    });
    final Map<String, dynamic> json =
        jsonDecode(utf8.decode(response.bodyBytes));
  if (kDebugMode) {
  print(json);
  }
    return (json['banners'] as List)
        .map((e) => BannerInfoEntity.fromJson(e))
        .toList();
  }
}