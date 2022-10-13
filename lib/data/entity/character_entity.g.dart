// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterEntity _$CharacterEntityFromJson(Map<String, dynamic> json) =>
    CharacterEntity(
      petId: json['petId'] as int,
      name: json['name'] as String,
      nickname: json['nickname'] as String?,
      image: json['image'] as String,
      currentLevel: json['currentLevel'] as int,
      currentExp: json['currentExp'] as int,
      maxExp: json['maxExp'] as int,
      remainedPlayTime: json['remainedPlayTime'] as int?,
      isPlayReady: json['isPlayReady'] as bool?,
    );

Map<String, dynamic> _$CharacterEntityToJson(CharacterEntity instance) =>
    <String, dynamic>{
      'petId': instance.petId,
      'name': instance.name,
      'nickname': instance.nickname,
      'image': instance.image,
      'currentLevel': instance.currentLevel,
      'currentExp': instance.currentExp,
      'maxExp': instance.maxExp,
      'remainedPlayTime': instance.remainedPlayTime,
      'isPlayReady': instance.isPlayReady,
    };
