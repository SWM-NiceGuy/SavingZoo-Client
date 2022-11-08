// stage1: {
// 			growState: true, // false 면 아직 실루엣만
// 			description: "수다리가 자연으로 무사히 돌아갈 수 있도록 ~~",
// 			weight: "0.2",
// 			height: "13",
// 			birthday: "2022-10-18" // "2022년 10월 18일" or TIMESTAMP?
// 		},

class GrowStage {
  final bool growState;
  final String? description;
  final String weight;
  final String height;
  final DateTime? grownDate;
  final int level;

  GrowStage({
    required this.growState,
    required this.level,
    this.description,
    required this.weight,
    required this.height,
    this.grownDate,
  });
}