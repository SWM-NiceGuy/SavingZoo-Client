import 'package:amond/domain/models/mission_list.dart';
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

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   print('미션 스크린 DISPOSE!\n\n\n');
  // }
}
