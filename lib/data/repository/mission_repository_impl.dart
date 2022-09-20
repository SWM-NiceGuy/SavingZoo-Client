import 'package:amond/data/entity/mission_entity.dart';
import 'package:amond/data/source/network/api/mission_api.dart';
import 'package:amond/domain/repositories/mission_repository.dart';

class MissionRepositoryImpl implements MissionRepository {

  final MissionApi api;

  MissionRepositoryImpl(this.api);

  /// 유저에게 할당된 모든 미션을 가져온다.
  @override
  Future<List<MissionEntity>> getAllMissions() async {
    final missions = await api.getAllMissions();
    return missions.toList();  
  }

  /// id가 [missionId]인 미션을 완료(COMPLETE) 처리한다.
  @override
  Future<void> completeMission(int missionId) async {
    try {
    await api.completeMission(missionId);
    } catch (e) {
      rethrow;
    }
  }
}