// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_history_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionHistoryEntity _$MissionHistoryEntityFromJson(
        Map<String, dynamic> json) =>
    MissionHistoryEntity(
      missionHistoryId: json['missionHistoryId'] as int,
      rewardType: json['rewardType'] as String,
      title: json['title'] as String,
      reward: json['reward'] as int,
      state: json['state'] as String,
      date: json['date'] as int,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$MissionHistoryEntityToJson(
        MissionHistoryEntity instance) =>
    <String, dynamic>{
      'missionHistoryId': instance.missionHistoryId,
      'rewardType': instance.rewardType,
      'title': instance.title,
      'reason': instance.reason,
      'reward': instance.reward,
      'state': instance.state,
      'date': instance.date,
    };
