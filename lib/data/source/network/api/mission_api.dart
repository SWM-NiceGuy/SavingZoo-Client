import 'dart:convert';
import 'dart:io';

import 'package:amond/data/entity/mission_entity.dart';
import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/utils/auth/auth_info.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class MissionApi {
  Future<Iterable<MissionEntity>> getAllMissions() async {
    final url = Uri.parse('$baseUrl/v1/mission');

    final response = await http.get(url, headers: {
      'Authorization': '$globalToken',
    });
    final Map<String, dynamic> result =
        jsonDecode(utf8.decode(response.bodyBytes));
    final List<dynamic> missionsList = result["missions"];
    Iterable<MissionEntity> missions =
        missionsList.map((e) => MissionEntity.fromJson(e));
    return missions;
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

  Future<void> uploadMission(int missionId, File file) async {
    final url = Uri.parse('uri');
    var request = http.MultipartRequest("POST", url);
    request.fields['user'] = 'blah'; // 바디에 필요한 필드
    var pic =
        await http.MultipartFile.fromPath("file_field", file.path); // 미션 사진
    request.files.add(pic);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
  }
}
