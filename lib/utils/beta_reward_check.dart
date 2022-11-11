import 'dart:convert';

import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/utils/auth/auth_info.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const String betaCheckedKey = 'betaChecked';

Future<bool> isChecked() async {
  final prefs = await SharedPreferences.getInstance();

  bool? isChecked = prefs.getBool(betaCheckedKey);

  if (isChecked == null) {
    return false;
  }
  return true;
}

Future<void> checkBeta() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(betaCheckedKey, true);
}

Future<Map<String, dynamic>> requestRewardIfNotChecked() async {

  if (await isChecked()) {
    return {'getReward': false};
  }

  final url = Uri.parse('$baseUrl/beta/check');
  final response = await http.get(url, headers: {
    'Authorization': 'Bearer $globalToken',
    'Content-type': 'application/json',
    'Accept': 'application/json',
  });

  final json = jsonDecode(response.body);

  if (kDebugMode) {
    print('베타유저 보상 체크 응답: ${response.body}\n');
  }

  await checkBeta();
  

  return {'getReward': json['isBetaUser'], 'reward': json['reward']};
}
