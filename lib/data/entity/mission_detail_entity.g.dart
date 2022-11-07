// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionDetailEntity _$MissionDetailEntityFromJson(Map<String, dynamic> json) =>
    MissionDetailEntity(
      name: json['name'] as String,
      content: json['content'] as String,
      description: json['description'] as String,
      exampleImageUrls: (json['exampleImageUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      submitGuide: json['submitGuide'] as String,
      reward: json['reward'] as int,
      state: json['state'] as String,
    );

Map<String, dynamic> _$MissionDetailEntityToJson(
        MissionDetailEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'content': instance.content,
      'description': instance.description,
      'exampleImageUrls': instance.exampleImageUrls,
      'submitGuide': instance.submitGuide,
      'reward': instance.reward,
      'state': instance.state,
    };
