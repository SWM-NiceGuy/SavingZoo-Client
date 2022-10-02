import 'package:amond/domain/models/mission_detail.dart';
import 'package:amond/domain/repositories/mission_repository.dart';
import 'package:flutter/foundation.dart';

class MissionDetailController with ChangeNotifier {

  final MissionRepository _missionRepository;

  bool _mounted = false;

  final int missionId;

  MissionDetailController(this._missionRepository, {required this.missionId});

  late final MissionDetail _missionDetail;
  MissionDetail get mission => _missionDetail;

  var _isLoading = true;
  bool get isLoading => _isLoading;

  var _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  /// 미션 상세 정보를 불러온다.
  Future<void> fetchData() async {

    _missionDetail = await _missionRepository.getMissionDetail(missionId);

    // _missionDetail = MissionDetail(
    //   name: '금속캔',
    //   description:
    //       "배달 음식의 편리함은 포기하기가 어려워요🥲 대신 음식이 담겼던 플라스틱 용기를 깨끗하게 세척하여 환경 보호 해봐요!",
    //   content: '금속캔 세척하고 압착하여 배출하기',
    //   submitGuide: "음식이 담겼던 플라스틱 용기를 깨끗히 세척 후 사진을 찍어 인증해주세요",
    //   exampleImageUrls: [
    //     'https://metacode.biz/@test/avatar.jpg',
    //     'https://metacode.biz/@test/avatar.jpg',
    //     'https://metacode.biz/@test/avatar.jpg',
    //     'https://metacode.biz/@test/avatar.jpg',
    //   ],
    //   reward: 8,
    //   state: 'INCOMPLETE');

    // // for test
    // await Future.delayed(const Duration(seconds: 2));
    if (_mounted) return;

    _isLoading = false;
    notifyListeners();
  }

  /// 미션 사진을 제출한다.
  Future<void> submit(String filePath) async {
    _isSubmitting = true;
    notifyListeners();

    // 서버의 STATE가 인증 대기중으로 바뀌어야 함
    // await missionRepository.submitMission();
    
    // for test
    await Future.delayed(Duration(seconds: 2));

    if (_mounted) return;

    _missionDetail.state = "WAITING";

    _isSubmitting = false;
    notifyListeners();
  }

  String get stateToButtonText {
    switch (mission.state) {
      case 'INCOMPLETE':
        return "인증하기";
      case 'WAITING':
       return "인증 대기중";
      case 'ACCEPTED' :
        return "미션 인증 완료";
      default:
       return "인증하기";
    }
  }

  @override
  void dispose() {
    _mounted = true;
    super.dispose();
  }
}