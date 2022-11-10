// stage1: {
// 			growState: true, // false 면 아직 실루엣만
// 			description: "수다리가 자연으로 무사히 돌아갈 수 있도록 ~~",
// 			weight: "0.2",
// 			height: "13",
// 			birthday: "2022-10-18" // "2022년 10월 18일" or TIMESTAMP?
// 		},

import 'package:amond/data/entity/grow_stage_entity.dart';

class GrowStage {
  final int stage;
  final bool growState;
  final String? description;
  final String weight;
  final String height;
  final DateTime? grownDate;
  final int level;

  GrowStage({
    required this.stage,
    required this.growState,
    required this.level,
    this.description,
    required this.weight,
    required this.height,
    this.grownDate,
  });

    factory GrowStage.fromEntity(GrowStageEntity entity) =>
      _$GrowStageFromEntity(entity);

  static GrowStage _$GrowStageFromEntity(GrowStageEntity entity) => GrowStage(
        stage: entity.stage,
        growState: entity.growState,
        description: entity.description,
        weight: entity.weight,
        height: entity.height,
        grownDate: DateTime.fromMillisecondsSinceEpoch(entity.grownDate),
        level: entity.level,
      );
}