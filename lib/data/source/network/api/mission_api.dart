import 'dart:convert';

import 'package:amond/data/entity/mission_entity.dart';
import 'package:http/http.dart' as http;

class MissionApi {
  Future<List<MissionEntity>> getAllMissions() async {
    final response = "";
    final List<MissionEntity> result = jsonDecode(response);
    return result;
  }
}