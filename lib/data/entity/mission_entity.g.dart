// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionEntity _$MissionEntityFromJson(Map<String, dynamic> json) =>
    MissionEntity(
      title: json['title'] as String,
      contents: json['contents'] as String,
      iconUrl: json['iconUrl'] as String,
      exp: json['exp'] as int,
      isDone: json['isDone'] as bool,
    );

Map<String, dynamic> _$MissionEntityToJson(MissionEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'contents': instance.contents,
      'iconUrl': instance.iconUrl,
      'exp': instance.exp,
      'isDone': instance.isDone,
    };
