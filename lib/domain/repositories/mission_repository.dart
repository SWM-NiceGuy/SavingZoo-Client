import 'package:amond/data/entity/mission_entity.dart';

abstract class MissionRepository {
  Future<List<MissionEntity>> getAllMissions();
  Future<void> completeMission(int missionId);
}