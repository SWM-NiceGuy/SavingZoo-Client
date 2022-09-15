import 'package:amond/data/entity/member_entity.dart';
import 'package:amond/data/entity/mission_entity.dart';
import 'package:amond/domain/models/member_info.dart';

abstract class MissionRepository {
  Future<List<MissionEntity>> getAllMissions(MemberInfo me);
  Future<void> completeMission(MemberInfo me, int missionId);
}