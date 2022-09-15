// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionEntity _$MissionEntityFromJson(Map<String, dynamic> json) =>
    MissionEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String,
      reward: json['reward'] as int,
      state: json['state'] as String,
    );

Map<String, dynamic> _$MissionEntityToJson(MissionEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'reward': instance.reward,
      'state': instance.state,
    };
