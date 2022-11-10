import 'package:json_annotation/json_annotation.dart';

part 'grow_history_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class GrowHistoryEntity {

  int birthday;
  String species;



  GrowHistoryEntity(this.birthday, this.species);

  factory GrowHistoryEntity.fromJson(Map<String, dynamic> json) => _$GrowHistoryEntityFromJson(json);
  Map<String, dynamic> toJson() => _$GrowHistoryEntityToJson(this);
}