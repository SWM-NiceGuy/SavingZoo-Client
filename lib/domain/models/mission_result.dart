import 'package:amond/domain/models/reward_type.dart';

class MissionResult {
  int totalCompletedMission;
  int totalRejectedMission;
  List<CompletedMission> completedMission;
  List<RejectedMission> rejectedMission;

  int get totalReward {
    int res = 0;
    for (var element in completedMission) {
      res += element.reward;
    }
    return res;
  }

  MissionResult({
    required this.totalCompletedMission,
    required this.totalRejectedMission,
    required this.completedMission,
    required this.rejectedMission,
  });
}

class CompletedMission {
  // "missionId": 15334,
  // "missionTitle": "금속 캔 압착",
  // "rewardType": "FISH",
  // "reward": 1

  int missionId;
  String missionTitle;
  RewardType rewardType;
  int reward;

  CompletedMission({
    required this.missionId,
    required this.missionTitle,
    required this.rewardType,
    required this.reward,
  });
}

class RejectedMission {
  // "missionTitle": "걷기",
  // "reason": "잘못된 사진"

  String missionTitle;
  String reason;

  RejectedMission({
    required this.missionTitle,
    required this.reason,
  });
}
