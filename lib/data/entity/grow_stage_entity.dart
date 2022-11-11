import 'package:json_annotation/json_annotation.dart';

part 'grow_stage_entity.g.dart';

@JsonSerializable()
class GrowStageEntity {
  // "growState": true,
  //           "description": "test(이)가 자연으로 무사히 돌아갈 수 있도록\n 잘 돌봐주세요!",
  //           "level": 1,
  //           "weight": 0.20,
  //           "height": 13,
  //           "grownDate": 1668063920690

  bool growState;
  String description;
  String? imageUrl;
  int stage;
  int level;
  String weight;
  String height;
  int grownDate;

  GrowStageEntity({
    required this.stage,
    required this.growState,
    required this.description,
    required this.level,
    required this.weight,
    required this.height,
    required this.grownDate,
    this.imageUrl,
  });

  factory GrowStageEntity.fromJson(Map<String, dynamic> json) =>
      _$GrowStageEntityFromJson(json);
  Map<String, dynamic> toJson() => _$GrowStageEntityToJson(this);
}
