import 'package:amond/data/source/network/api/mission_api.dart';
import 'package:amond/domain/models/mission_detail.dart';
import 'package:amond/domain/models/mission_history.dart';
import 'package:amond/domain/models/mission_list.dart';
import 'package:amond/domain/models/mission_result.dart';
import 'package:amond/domain/repositories/mission_repository.dart';

class MissionRepositoryImpl implements MissionRepository {

  final MissionApi api;

  MissionRepositoryImpl(this.api);

  /// 유저에게 할당된 모든 미션을 가져온다.
  @override
  Future<List<MissionList>> getAllMissions() async {
    final missions = await api.getAllMissions();
    return missions.map((e) => MissionList.fromEntity(e)).toList();  
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

  @override
  Future<MissionDetail> getMissionDetail(int missionId) async {
    try {
    final missionDetail = await api.getMissionDetail(missionId);
    return MissionDetail.fromEntity(missionDetail);
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<void> submitMission(int missionId, String filePath) async {
    try {
      await api.uploadMission(missionId, filePath);
    }
    catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MissionHistory>> getMissionHistories() async {
    final entityList = await api.getMissionHistories();
    entityList.sort((a, b) => b.date - a.date);
    return entityList.map((e) => MissionHistory.fromEntity(e)).toList();
  }

  @override
  Future<MissionResult> getMissionResult() {
    // TODO: implement getMissionResult
    throw UnimplementedError();
  }
  
  @override
  Future<void> confirmResult() {
    // TODO: implement confirmResult
    throw UnimplementedError();
  }
}
