import 'package:amond/domain/models/mission_list.dart';
import 'package:amond/domain/models/mission_state.dart';
import 'package:amond/domain/repositories/mission_repository.dart';
import 'package:flutter/material.dart';

class MissionController with ChangeNotifier {
  final MissionRepository _missionRepository;

  MissionController(this._missionRepository);

  var isLoading = true;

  List<MissionList> _missions = [];
  List<MissionList> get missions => [..._missions];

  /// 미션들을 불러온다.
  Future<void> fetchMissions() async {
    List<MissionList> missions;
    try {
      missions = await _missionRepository.getAllMissions();
    } catch (error) {
      rethrow;
    }
    _missions = missions;
    isLoading = false;
    notifyListeners();
  }

  // 미션을 완료 처리로 바꾼다.
//   Future<void> completeMission(int missionId) async {
//     var missionIdx =_missions.indexWhere((mission) => mission.id == missionId);
//     if (missionIdx < 0) return;

//     _missions[missionIdx].state = MissionState.completed;
//     try {
//       await _missionRepository.completeMission(missionId);
//     } catch (error) {
//       // 미션 완료 처리에 실패하면 다시 완료대기 상태로 변경
//       _missions[missionIdx].state = "WAIT";
//       rethrow;
//     }
//     notifyListeners();
//   }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('미션 스크린 DISPOSE!\n\n\n');
  }
}
