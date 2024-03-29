// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterEntity _$CharacterEntityFromJson(Map<String, dynamic> json) =>
    CharacterEntity(
      petId: json['petId'] as int,
      species: json['species'] as String,
      nickname: json['nickname'] as String?,
      image: json['image'] as String,
      currentStage: json['currentStage'] as int,
      currentLevel: json['currentLevel'] as int,
      currentExp: json['currentExp'] as int,
      maxExp: json['maxExp'] as int,
      remainedPlayTime: json['remainedPlayTime'] as int?,
      isPlayReady: json['isPlayReady'] as bool?,
    );

Map<String, dynamic> _$CharacterEntityToJson(CharacterEntity instance) =>
    <String, dynamic>{
      'petId': instance.petId,
      'species': instance.species,
      'nickname': instance.nickname,
      'image': instance.image,
      'currentLevel': instance.currentLevel,
      'currentStage': instance.currentStage,
      'currentExp': instance.currentExp,
      'maxExp': instance.maxExp,
      'remainedPlayTime': instance.remainedPlayTime,
      'isPlayReady': instance.isPlayReady,
    };
