import 'package:json_annotation/json_annotation.dart';

part 'character_entity.g.dart';

@JsonSerializable()
class CharacterEntity {

  final int petId;
  final String name;
  String? nickname;
  final String image;
  final int currentLevel;
  final int currentExp;
  final int maxExp;


  CharacterEntity({
    required this.petId,
    required this.name,
    this.nickname,
    required this.image,
    required this.currentLevel,
    required this.currentExp,
    required this.maxExp,
  });

  factory CharacterEntity.fromJson(Map<String, dynamic> json) => _$CharacterEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterEntityToJson(this);
}