import 'package:json_annotation/json_annotation.dart';

part 'character_entity.g.dart';

@JsonSerializable()
class CharacterEntity {

  final int id;
  String? name;
  final String nickname;
  final String imageUrl;
  final int currentLevel;
  final int currentExp;
  final int maxExp;


  CharacterEntity({
    required this.id,
    this.name,
    required this.nickname,
    required this.imageUrl,
    required this.currentLevel,
    required this.currentExp,
    required this.maxExp,
  });

  factory CharacterEntity.fromJson(Map<String, dynamic> json) => _$CharacterEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterEntityToJson(this);
}