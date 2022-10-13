import 'package:amond/data/entity/character_entity.dart';

class Character {
  final int id;
  final String name;
  String? nickname;
  final String imageUrl;
  final int level;
  int currentExp;
  int maxExp;
  int? remainedTime;
  bool? isPlayReady;

  double get expPct => currentExp / maxExp;

  Character({
    required this.id,
    required this.name,
    required this.nickname,
    required this.imageUrl,
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
        name: name,
        nickname: nickname,
        image: imageUrl,
        currentLevel: level,
        currentExp: currentExp,
        maxExp: maxExp,
      );

  static Character _$CharacterFromEntity(CharacterEntity entity) => Character(
        id: entity.petId,
        name: entity.name,
        level: entity.currentLevel,
        nickname: entity.nickname,
        imageUrl: entity.image,
        currentExp: entity.currentExp,
        maxExp: entity.maxExp,
        remainedTime: entity.remainedPlayTime,
      );
}
