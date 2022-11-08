import 'package:json_annotation/json_annotation.dart';

part 'rejected_mission_entity.g.dart';

@JsonSerializable()
class RejectedMissionEntity {

  String missionTitle;
  String reason;

  RejectedMissionEntity({required this.missionTitle, required this.reason});

  factory RejectedMissionEntity.fromJson(Map<String, dynamic> json) => _$RejectedMissionEntityFromJson(json);
  Map<String, dynamic> toJson() => _$RejectedMissionEntityToJson(this);
}