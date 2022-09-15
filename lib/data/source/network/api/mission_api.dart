import 'dart:convert';

import 'package:amond/data/entity/member_entity.dart';
import 'package:amond/data/entity/mission_entity.dart';
import 'package:amond/data/source/network/base_url.dart';
import 'package:http/http.dart' as http;

class MissionApi {
  Future<Iterable<MissionEntity>> getAllMissions(MemberEntity me) async {
    final url = Uri.parse('$baseUrl/v1/mission?provider=${me.provider}&uid=${me.uid}');

    final response = await http.get(url);
    final Iterable<Map<String, dynamic>> result = jsonDecode(response.body);
    Iterable<MissionEntity> missions = result.map((e) => MissionEntity.fromJson(e));
    return missions;
  }

  Future<void> completeMission(MemberEntity me, int missionId) async {
    final url = Uri.parse('$baseUrl/v1/mission');
    try {
    final response = await http.put(url, body: jsonEncode({
      "provider": me.provider,
      "uid": me.uid,
      "missionId": missionId,
    }));
    if (response.statusCode == 400) {
      throw Exception("미션완료에 실패했습니다. status_code: 400");
    }
    } catch (e) {
      rethrow;
    }
  }
}