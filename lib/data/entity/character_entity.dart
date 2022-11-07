import 'package:json_annotation/json_annotation.dart';

part 'character_entity.g.dart';

@JsonSerializable()
class CharacterEntity {

  final int petId;
  final String species;
  String? nickname;
  final String image;
  final int currentLevel;
  final int currentStage;
  final int currentExp;
  final int maxExp;
  final int? remainedPlayTime;
  final bool? isPlayReady;  


  CharacterEntity({
    required this.petId,
    required this.species,
    this.nickname,
    required this.image,
    required this.currentStage,
    required this.currentLevel,
    required this.currentExp,
    required this.maxExp,
    this.remainedPlayTime,
    this.isPlayReady
  });

  factory CharacterEntity.fromJson(Map<String, dynamic> json) => _$CharacterEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterEntityToJson(this);
}