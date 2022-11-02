import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';

part 'completed_mission_entity.g.dart';

@JsonSerializable()
class CompletedMissionEntity {

  int missionId;
  String missionTitle;
  String rewardType;
  int reward;

  CompletedMissionEntity({
    required this.missionId,
    required this.missionTitle,
    required this.rewardType,
    required this.reward,
  });

  factory CompletedMissionEntity.fromJson(Map<String, dynamic> json) => _$CompletedMissionEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CompletedMissionEntityToJson(this);
}