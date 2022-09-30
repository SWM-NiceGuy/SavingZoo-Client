// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterEntity _$CharacterEntityFromJson(Map<String, dynamic> json) =>
    CharacterEntity(
      id: json['id'] as int,
      name: json['name'] as String?,
      nickname: json['nickname'] as String,
      imageUrl: json['imageUrl'] as String,
      currentLevel: json['currentLevel'] as int,
      currentExp: json['currentExp'] as int,
      maxExp: json['maxExp'] as int,
    );

Map<String, dynamic> _$CharacterEntityToJson(CharacterEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nickname': instance.nickname,
      'imageUrl': instance.imageUrl,
      'currentLevel': instance.currentLevel,
      'currentExp': instance.currentExp,
      'maxExp': instance.maxExp,
    };
