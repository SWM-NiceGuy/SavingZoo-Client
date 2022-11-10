import 'package:amond/domain/models/grow_stage.dart';

class GrowHistory {
  final String petName;
  final String species;
  final DateTime birth;
  final List<GrowStage> stages;

  const GrowHistory({
    required this.petName,
    required this.species,
    required this.stages,
    required this.birth,
  });
  
  /// '함께한지 6일'
  /// 아직 성장하지 않은 상태이면 '???'를 반환
  String growDifference (int index) {
    String? daysInString = stages[index].grownDate?.difference(birth).inDays.toString();
    return daysInString == null ? '???' : '함께한지 $daysInString일';
  }
}