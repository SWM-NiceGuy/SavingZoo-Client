import 'package:amond/data/entity/mission_entity.dart';
import 'package:amond/domain/models/member_info.dart';
import 'package:amond/domain/repositories/mission_repository.dart';
import 'package:flutter/material.dart';

class MissionController with ChangeNotifier {

  final MissionRepository repository;
  late MemberInfo me;

  MissionController(this.repository, {required MemberInfo member}) {
    me = member;
  }

  var isLoading = true;
  
  List<MissionEntity> _missions = [];
  List<MissionEntity> get missions => [..._missions];

  /// 미션들을 불러온다.
  Future<void> fetchMissions() async {
    isLoading = true;
    notifyListeners();
    List<MissionEntity> missions;
    try {
      missions = await repository.getAllMissions(me);
    } catch (error) {
      rethrow;
    }
    _missions = missions;
    isLoading = false;
    notifyListeners();
  }

  // 미션을 완료 처리로 바꾼다.
  Future<void> completeMission(int missionId) async {
    var missionIdx =_missions.indexWhere((mission) => mission.id == missionId);
    _missions[missionIdx].state = "COMPLETE";
    try {
      await repository.completeMission(me, missionId);
    } catch (error) {
      // 미션 완료 처리에 실패하면 다시 대기 상태로 변경
      _missions[missionIdx].state = "WAIT";
      rethrow;
    }
    notifyListeners();
  }
}