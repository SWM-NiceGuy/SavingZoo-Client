import 'dart:convert';

import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/utils/version/app_notice.dart';
import 'package:http/http.dart' as http;

late AppNotice appNotice;

Future<AppNotice> getAppNotice() async {
  final url = Uri.parse('$baseUrl/notice');

  final response = await http.get(url);
  final json = jsonDecode(utf8.decode(response.bodyBytes));

  appNotice = AppNotice.fromJson(json);

  return appNotice;
}

bool isNoticed = false;