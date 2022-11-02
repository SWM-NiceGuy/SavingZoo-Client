// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_mission_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletedMissionEntity _$CompletedMissionEntityFromJson(
        Map<String, dynamic> json) =>
    CompletedMissionEntity(
      missionId: json['missionId'] as int,
      missionTitle: json['missionTitle'] as String,
      rewardType: json['rewardType'] as String,
      reward: json['reward'] as int,
    );

Map<String, dynamic> _$CompletedMissionEntityToJson(
        CompletedMissionEntity instance) =>
    <String, dynamic>{
      'missionId': instance.missionId,
      'missionTitle': instance.missionTitle,
      'rewardType': instance.rewardType,
      'reward': instance.reward,
    };
