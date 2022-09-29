import 'package:amond/domain/models/mission_detail.dart';
import 'package:amond/domain/repositories/mission_repository.dart';
import 'package:flutter/foundation.dart';

class MissionDetailController with ChangeNotifier {

  final MissionRepository missionRepository;

  bool _mounted = false;

  final int missionId;

  MissionDetailController(this.missionRepository, {required this.missionId});

  late final MissionDetail _missionDetail;
  MissionDetail get mission => _missionDetail;

  var _isLoading = true;
  bool get isLoading => _isLoading;

  var _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  /// 미션 상세 정보를 불러온다.
  Future<void> fetchData() async {

    // _missionDetail = await missionRepository.getMissionDetail(missionId);

    // 테스트를 위한 딜레이
    await Future.delayed(const Duration(seconds: 2));
    if (_mounted) return;

    _isLoading = false;
    notifyListeners();
  }

  /// 미션 사진을 제출한다.
  Future<void> submit() async {
    _isSubmitting = true;
    notifyListeners();

    await missionRepository.submitMission();

    _isSubmitting = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = true;
    super.dispose();
  }
}