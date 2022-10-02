import 'dart:convert';

import 'package:amond/data/entity/mission_detail_entity.dart';
import 'package:amond/data/entity/mission_list_entity.dart';
import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/utils/auth/auth_info.dart';
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
    print(result);
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
    final url = Uri.parse('uri');
    var request = http.MultipartRequest("POST", url);
    request.fields['user'] = 'blah'; // 바디에 필요한 필드
    var pic =
        await http.MultipartFile.fromPath("file_field", filePath); // 미션 사진
    request.files.add(pic);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
  }
}
