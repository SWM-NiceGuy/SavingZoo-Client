import 'dart:convert';

import 'package:amond/data/entity/mission_entity.dart';
import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/domain/models/member_info.dart';
import 'package:http/http.dart' as http;

class MissionApi {
  
  Future<Iterable<MissionEntity>> getAllMissions(MemberInfo me) async {
    final url = Uri.parse('$baseUrl/v1/mission?provider=${me.provider}&uid=${me.uid}');

    final response = await http.get(url);
    final Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
    final List<dynamic> missionsList = result["missions"];
    Iterable<MissionEntity> missions = missionsList.map((e) => MissionEntity.fromJson(e));
    return missions;
  }

  Future<void> completeMission(MemberInfo me, int missionId) async {
    final url = Uri.parse('$baseUrl/v1/mission');
    try {
    final response = await http.put(url, body: jsonEncode({
      "provider": me.provider,
      "uid": me.uid,
      "missionId": missionId,
    }), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 400) {
      throw Exception("미션완료에 실패했습니다. status_code: 400");
    }
    } catch (e) {
      rethrow;
    }
  }
}