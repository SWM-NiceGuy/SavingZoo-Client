import 'package:json_annotation/json_annotation.dart';

part 'mission_entity.g.dart';

@JsonSerializable()
class MissionEntity {
  final int id;
  final String title;
  final String content;
  final String imageUrl;
  final int reward;
  String state;

  MissionEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.reward,
    required this.state,
  });


  factory MissionEntity.fromJson(Map<String, dynamic> json) => _$MissionEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MissionEntityToJson(this);
}