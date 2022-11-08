import 'package:json_annotation/json_annotation.dart';

part 'mission_list_entity.g.dart';

@JsonSerializable()
class MissionListEntity {
  final int id;
  final String name;
  final String category;
  final String iconUrl;
  final int reward;
  String state;

  MissionListEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.iconUrl,
    required this.state,
    required this.reward,
  });

  factory MissionListEntity.fromJson(Map<String, dynamic> json) =>
      _$MissionListEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MissionListEntityToJson(this);
}
