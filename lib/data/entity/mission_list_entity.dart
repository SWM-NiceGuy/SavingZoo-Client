import 'package:json_annotation/json_annotation.dart';

part 'mission_list_entity.g.dart';

@JsonSerializable()
class MissionListEntity {
  final int id;
  final String name;
  final String iconUrl;
  String state;

  MissionListEntity({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.state
  });


  factory MissionListEntity.fromJson(Map<String, dynamic> json) => _$MissionListEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MissionListEntityToJson(this);
}