import 'package:amond/data/entity/grow_stage_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grow_history_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class GrowHistoryEntity {

  int birthday;
  String species;
  String petName;
  List<GrowStageEntity> stages;



  GrowHistoryEntity({
    required this.birthday,
    required this.species,
    required this.petName,
    required this.stages,
  });

  factory GrowHistoryEntity.fromJson(Map<String, dynamic> json) => _$GrowHistoryEntityFromJson(json);
  Map<String, dynamic> toJson() => _$GrowHistoryEntityToJson(this);
}