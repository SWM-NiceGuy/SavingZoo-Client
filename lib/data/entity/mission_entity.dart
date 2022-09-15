import 'package:json_annotation/json_annotation.dart';

part 'mission_entity.g.dart';

@JsonSerializable()
class MissionEntity {
  // provider, email, nickname, gender, age
  final String title;
  final String contents;
  final String iconUrl;
  final int exp;
  final bool isDone;

  MissionEntity({
    required this.title,
    required this.contents,
    required this.iconUrl,
    required this.exp,
    required this.isDone
  });


  factory MissionEntity.fromJson(Map<String, dynamic> json) => _$MissionEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MissionEntityToJson(this);
}