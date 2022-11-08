import 'package:json_annotation/json_annotation.dart';

part 'mission_history_entity.g.dart';

@JsonSerializable()
class MissionHistoryEntity {

  int missionHistoryId;
  String rewardType;
  String title;
  String? reason;
  int reward;
  String state;
  int date;

  MissionHistoryEntity({
    required this.missionHistoryId,
    required this.rewardType,
    required this.title,
    required this.reward,
    required this.state,
    required this.date,
    this.reason,
  });

  factory MissionHistoryEntity.fromJson(Map<String, dynamic> json) => _$MissionHistoryEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MissionHistoryEntityToJson(this);
}