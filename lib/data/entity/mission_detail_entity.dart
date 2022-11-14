import 'package:json_annotation/json_annotation.dart';

part 'mission_detail_entity.g.dart';

  // String name;
  // String content;
  // String description;
  // List<String> exampleImageUrls;
  // String submitGuide;
  // int reward;
  // String state;

@JsonSerializable()
class MissionDetailEntity {
  final String name;
  final String content;
  final String description;
  final List<String> exampleImageUrls;
  final String submitGuide;
  final int reward;
  final String state;
  final String submitImageUrl;

  MissionDetailEntity({
    required this.name,
    required this.content,
    required this.description,
    required this.exampleImageUrls,
    required this.submitGuide,
    required this.reward,
    required this.state,
    required this.submitImageUrl,
  });


  factory MissionDetailEntity.fromJson(Map<String, dynamic> json) => _$MissionDetailEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MissionDetailEntityToJson(this);
}