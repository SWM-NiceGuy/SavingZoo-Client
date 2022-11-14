import 'package:amond/domain/models/mission_detail.dart';
import 'package:amond/domain/models/mission_history.dart';
import 'package:amond/domain/models/mission_list.dart';
import 'package:amond/domain/models/mission_result.dart';

abstract class MissionRepository {
  Future<List<MissionList>> getAllMissions();
  Future<void> completeMission(int missionId);
  Future<MissionDetail> getMissionDetail(int missionId);
  Future<void> submitMission(int missionId, String filePath);
  Future<List<MissionHistory>> getMissionHistories();
  Future<MissionResult> getMissionResult();
  Future<void> confirmResult(List<int> missionIds);
}
