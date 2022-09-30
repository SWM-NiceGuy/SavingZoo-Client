import 'package:amond/data/entity/character_entity.dart';

class Character {
  final int id;
  String? name;
  final String nickname;
  final String imageUrl;
  final int level;
  int currentExp;
  final int maxExp;

  double get expPct => currentExp / maxExp;

  Character(
      {required this.id,
      required this.name,
      required this.nickname,
      required this.imageUrl,
      this.level = 1,
      this.currentExp = 5,
      required this.maxExp});

  factory Character.fromEntity(CharacterEntity entity) =>
      _$CharacterFromEntity(entity);

  CharacterEntity toEntity() => CharacterEntity(
        id: id,
        nickname: nickname,
        imageUrl: imageUrl,
        currentLevel: level,
        currentExp: currentExp,
        maxExp: maxExp,
      );

  static Character _$CharacterFromEntity(CharacterEntity entity) => Character(
        id: entity.id,
        name: entity.name,
        nickname: entity.nickname,
        imageUrl: entity.imageUrl,
        maxExp: entity.maxExp,
      );
}
