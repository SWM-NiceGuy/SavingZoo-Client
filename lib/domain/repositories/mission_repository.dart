import 'package:amond/data/entity/member_entity.dart';
import 'package:amond/data/entity/mission_entity.dart';

abstract class MissionRepository {
  Future<List<MissionEntity>> getAllMissions(MemberEntity me);
  Future<void> completeMission(MemberEntity me, int missionId);
}