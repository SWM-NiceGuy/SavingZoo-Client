import 'package:amond/data/entity/mission_entity.dart';
import 'package:amond/domain/models/mission_detail.dart';

abstract class MissionRepository {
  Future<List<MissionEntity>> getAllMissions();
  Future<void> completeMission(int missionId);
  Future<MissionDetail> getMissionDetail(int missionId);
  Future<bool> submitMission(String filePath);
}
