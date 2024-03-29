import 'dart:convert';

import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/utils/version/app_status.dart';
import 'package:http/http.dart' as http;

// TODO: 앱 배포하기 전 버전 설정
const String appVersion = '2.0.0';
late AppStatus currentAppStatus;

const String appStoreUrl =
    "https://apps.apple.com/kr/app/%EC%95%84%EB%AA%AC%EB%93%9C-%ED%99%98%EA%B2%BD-%EB%B3%B4%ED%98%B8-%ED%99%9C%EB%8F%99%EC%9D%84-%ED%86%B5%ED%95%B4-%EC%BA%90%EB%A6%AD%ED%84%B0-%ED%82%A4%EC%9A%B0%EA%B8%B0/id1642916442";
const String playStoreUrl =
    "https://play.google.com/store/apps/details?id=com.amond.amondApp";

Future<AppStatus> getAppStatus() async {
  final url = Uri.parse('https://api.amondfarm.com/v1/check/$appVersion');

  final res = await http.get(url);
  currentAppStatus = AppStatus.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));

  baseUrl = currentAppStatus.apiUrl;
  
  return currentAppStatus;
}

// Future<String> getLatestVersion() async {
//   final url = Uri.parse('$baseUrl/check/$appVersion');

//   final res = await http.get(url);
//   final version = jsonDecode(res.body)["latestVersion"];
//   return version;
// }

bool isNoticed = false;
