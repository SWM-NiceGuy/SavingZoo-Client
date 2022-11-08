import 'dart:convert';

import 'package:amond/data/entity/mission_detail_entity.dart';
import 'package:amond/data/entity/mission_history_entity.dart';
import 'package:amond/data/entity/mission_list_entity.dart';
import 'package:amond/data/entity/mission_result_entity.dart';
import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/utils/auth/auth_info.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:http/http.dart' as http;

class MissionApi {
  Future<Iterable<MissionListEntity>> getAllMissions() async {
    final url = Uri.parse('$baseUrl/user/mission/daily');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $globalToken',
    });
    final Map<String, dynamic> result =
        jsonDecode(utf8.decode(response.bodyBytes));
    final List<dynamic> missionsList = result["missions"];
    Iterable<MissionListEntity> missions =
        missionsList.map((e) => MissionListEntity.fromJson(e));
    return missions;
  }

  Future<MissionDetailEntity> getMissionDetail(int missionId) async {
    final url = Uri.parse('$baseUrl/user/mission/$missionId');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $globalToken',
    });
    final Map<String, dynamic> result =
        jsonDecode(utf8.decode(response.bodyBytes));
    final missionDetail = MissionDetailEntity.fromJson(result);
    return missionDetail;
  }

  Future<void> completeMission(int missionId) async {
    final url = Uri.parse('$baseUrl/v1/mission');
    try {
      final response = await http.put(url,
          body: jsonEncode({
            "missionId": missionId,
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $globalToken',
          });
      if (response.statusCode == 400) {
        throw Exception("미션완료에 실패했습니다. status_code: 400");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadMission(int missionId, String filePath) async {
    try {
      final url = Uri.parse('$baseUrl/user/mission/$missionId');
      var request = http.MultipartRequest("POST", url);
      request.headers['Authorization'] = 'Bearer $globalToken'; // 인증 토큰 추가
      // request.fields['missionId'] = missionId.toString(); // 바디에 필요한 필드
      var pic =
          await http.MultipartFile.fromPath("multipartFile", filePath); // 미션 사진
      request.files.add(pic);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode >= 400) {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      // print(e);
      throw Exception('사진 전송 실패 code: ${e.toString()}');
    }
  }

  Future<List<MissionHistoryEntity>> getMissionHistories() async {
    final url = Uri.parse('$baseUrl/user/mission/history');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $globalToken',
    });
    final Map<String, dynamic> result =
        jsonDecode(utf8.decode(response.bodyBytes));

    List historiesJson = result['missionHistories'];
    return historiesJson.map((e) => MissionHistoryEntity.fromJson(e)).toList();
  }

  Future<MissionResultEntity> getMissionResult() async {
    final url = Uri.parse('$baseUrl/user/mission/check');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $globalToken',
    });

    final Map<String, dynamic> json =
        jsonDecode(utf8.decode(response.bodyBytes));
    final missionResult = MissionResultEntity.fromJson(json);

    return missionResult;
  }

  Future<void> confirmResult(List<int> missionIds) async {
    try {
      final url = Uri.parse('$baseUrl/user/mission/reward');
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $globalToken',
        },
        body: jsonEncode({
          "missions": missionIds,
        }),
      );
      // print(response.body);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
