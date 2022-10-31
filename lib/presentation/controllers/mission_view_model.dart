import 'package:amond/domain/models/mission_list.dart';
import 'package:amond/domain/repositories/mission_repository.dart';
import 'package:flutter/material.dart';

class MissionViewModel with ChangeNotifier {
  final MissionRepository _missionRepository;

  MissionViewModel(this._missionRepository);

  // 기초 미션 목록
  final List<MissionList> _basicMissions = [];
  List<MissionList> get basicMissions => _basicMissions;

  // 중급 미션 목록
  final List<MissionList> _intermediateMissions = [];
  List<MissionList> get intermediateMissions => _intermediateMissions;

  // 상급 미션 목록
  final List<MissionList> _advancedMissions = [];
  List<MissionList> get advancedMissions => _advancedMissions;

  // 로딩 상태
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  /// 미션들을 불러온다.
  Future<void> fetchMissions() async {
    _isLoading = true;
    notifyListeners();

    try {
      final missions = await _missionRepository.getAllMissions();

      // 모든 미션들을 초기화한다
      _basicMissions.clear();
      _intermediateMissions.clear();
      _advancedMissions.clear();

      for (final mission in missions) {
        switch (mission.reward) {
          case 10:
            _basicMissions.add(mission);
            break;
          case 20:
            _intermediateMissions.add(mission);
            break;
          case 30:
            _advancedMissions.add(mission);
            break;
          default:
            throw Exception('미션의 보상이 규격에서 벗어났습니다');
        }
      }
    } catch (error) {
      rethrow;
    }

    _isLoading = false;
    notifyListeners();
  }
}
