import 'package:amond/domain/models/grow_stage.dart';

class GrowHistory {
  final String petName;
  final double expPct;
  final List<GrowStage> stages;

  const GrowHistory({
    required this.petName,
    required this.expPct,
    required this.stages,
  });
}