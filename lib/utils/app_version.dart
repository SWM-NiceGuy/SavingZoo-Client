import 'dart:convert';

import 'package:amond/data/source/network/base_url.dart';
import 'package:http/http.dart' as http;

const String appVersion = '1.1.0';
String? latestVersion;

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