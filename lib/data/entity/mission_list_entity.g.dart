// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionListEntity _$MissionListEntityFromJson(Map<String, dynamic> json) =>
    MissionListEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      iconUrl: json['iconUrl'] as String,
      state: json['state'] as String,
      reward: json['reward'] as int,
    );

Map<String, dynamic> _$MissionListEntityToJson(MissionListEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconUrl': instance.iconUrl,
      'reward': instance.reward,
      'state': instance.state,
    };
