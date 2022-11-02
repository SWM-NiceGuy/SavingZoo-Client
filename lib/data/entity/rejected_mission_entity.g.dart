// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rejected_mission_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejectedMissionEntity _$RejectedMissionEntityFromJson(
        Map<String, dynamic> json) =>
    RejectedMissionEntity(
      missionTitle: json['missionTitle'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$RejectedMissionEntityToJson(
        RejectedMissionEntity instance) =>
    <String, dynamic>{
      'missionTitle': instance.missionTitle,
      'reason': instance.reason,
    };
