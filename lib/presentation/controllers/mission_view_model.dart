import 'package:amond/domain/models/mission_list.dart';
import 'package:amond/domain/models/mission_result.dart';
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

  // 카테고리 목록
  final List<String> _categories = [];
  List<String> get categories => _categories;

  // 선택된 카테고리
  String _selectedCategory = '전체';
  String get selectedCategory => _selectedCategory;

  // 로딩 상태
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  /// 미션들을 불러온다.
  ///
  /// 특정 카테고리의 미션만 가져오고 싶다면 categoryName에 카테고리의 이름을 넣어 호출한다
  Future<void> fetchMissions({String? categoryName}) async {
    _isLoading = true;
    notifyListeners();

    // 선택된 카테고리 설정
    if (categoryName != null) {
      _selectedCategory = categoryName;
    }

    // 카테고리 이름이 '전체' 라면 모든 미션을 불러온다
    if (categoryName == '전체') {
      categoryName = null;
    }

    try {
      final missions = await _missionRepository.getAllMissions();

      // 모든 미션들을 초기화한다
      _basicMissions.clear();
      _intermediateMissions.clear();
      _advancedMissions.clear();

      // 카테고리들을 초기화한다
      _categories
        ..clear()
        ..add('전체');

      Set<int> rewardSet = <int>{};

      // 보상 타입 분류 및 카테고리 추가
      for (final mission in missions) {
        rewardSet.add(mission.reward);

        if (!_categories.contains(mission.category)) {
          _categories.add(mission.category);
        }
      }

      List<int> rewardList = rewardSet.toList()..sort();

      for (final mission in missions) {
        if (categoryName != null && categoryName != mission.category) {
          continue;
        }

        if (mission.reward == rewardList.first) {
          _basicMissions.add(mission);
        } else if (mission.reward == rewardList.last) {
          _advancedMissions.add(mission);
        } else {
          _intermediateMissions.add(mission);
        }
      }
    } catch (error) {
      rethrow;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// 인증된(성공 또는 반려) 미션 결과를 가져온다.
  Future<MissionResult> getMissionResult() async {
    MissionResult? result = await _missionRepository.getMissionResult();

    // 테스트용 미션 결과
    // var result = MissionResult(
    //   totalCompletedMission: 2,
    //   totalRejectedMission: 2,
    //   completedMission: [
    //     CompletedMission(missionId: 1, missionTitle: '금속 캔 압착', rewardType: RewardType.fish, reward: 1),
    //     CompletedMission(missionId: 2, missionTitle: '플로깅', rewardType: RewardType.fish, reward: 2),
    //   ],
    //   rejectedMission: [
    //     RejectedMission(missionTitle: '걷기', reason: '날고 있음'),
    //     RejectedMission(missionTitle: 'PET라벨 제거', reason: '라벨 부착 됨')
    //   ],
    // );
    return result;
  }

  /// 보상을 받았다는 표시를 서버에 보낸다
  Future<void> confirmResult(List<int> missionIds) async {
    await _missionRepository.confirmResult(missionIds);
  }
}
