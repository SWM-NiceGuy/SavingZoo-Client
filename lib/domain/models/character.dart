import 'package:amond/data/entity/character_entity.dart';

class Character {
  final int id;
  final String species;
  String? nickname;
  final String imageUrl;
  final int level;
  final int currentStage;
  int currentExp;
  int maxExp;
  int? remainedTime;
  bool? isPlayReady;

  double get expPct => currentExp / maxExp;

  Character({
    required this.id,
    required this.species,
    required this.nickname,
    required this.imageUrl,
    required this.currentStage,
    this.level = 1,
    this.currentExp = 0,
    required this.maxExp,
    this.remainedTime,
    this.isPlayReady,
  });

  factory Character.fromEntity(CharacterEntity entity) =>
      _$CharacterFromEntity(entity);

  CharacterEntity toEntity() => CharacterEntity(
        petId: id,
        species: species,
        nickname: nickname,
        image: imageUrl,
        currentLevel: level,
        currentExp: currentExp,
        maxExp: maxExp,
        currentStage: currentStage
      );

  static Character _$CharacterFromEntity(CharacterEntity entity) => Character(
        id: entity.petId,
        species: entity.species,
        level: entity.currentLevel,
        nickname: entity.nickname,
        imageUrl: entity.image,
        currentExp: entity.currentExp,
        maxExp: entity.maxExp,
        remainedTime: entity.remainedPlayTime,
        currentStage: entity.currentStage,
      );
}
