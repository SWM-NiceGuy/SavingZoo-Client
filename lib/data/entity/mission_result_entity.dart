import 'package:amond/data/entity/completed_mission_entity.dart';
import 'package:amond/data/entity/rejected_mission_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mission_result_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class MissionResultEntity {

  int totalCompletedMission;
  int totalRejectedMission;
  List<CompletedMissionEntity> completedMissions;
  List<RejectedMissionEntity> rejectedMissions;

  MissionResultEntity({
    required this.totalCompletedMission,
    required this.totalRejectedMission,
    required this.completedMissions,
    required this.rejectedMissions,
  });

  factory MissionResultEntity.fromJson(Map<String, dynamic> json) => _$MissionResultEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MissionResultEntityToJson(this);
}