import 'dart:convert';

import 'package:amond/data/source/network/base_url.dart';
import 'package:http/http.dart' as http;

const String appVersion = '1.1.1';
String? latestVersion;

const String appStoreUrl = "https://apps.apple.com/kr/app/%EC%95%84%EB%AA%AC%EB%93%9C-%ED%99%98%EA%B2%BD-%EB%B3%B4%ED%98%B8-%ED%99%9C%EB%8F%99%EC%9D%84-%ED%86%B5%ED%95%B4-%EC%BA%90%EB%A6%AD%ED%84%B0-%ED%82%A4%EC%9A%B0%EA%B8%B0/id1642916442";
const String playStoreUrl = "https://play.google.com/store/apps/details?id=com.amond.amondApp";

Future<String> getLatestVersion() async {
  final url = Uri.parse('$baseUrl/v1/version');

  final res = await http.get(url);
  final version = jsonDecode(res.body)["version"];
  return version;
}

Future<bool> isLatestVersion() async {
  final resLatestVersion = await getLatestVersion();
  latestVersion = resLatestVersion;
  return appVersion == resLatestVersion;
}