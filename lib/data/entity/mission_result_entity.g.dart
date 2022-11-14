// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_result_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionResultEntity _$MissionResultEntityFromJson(Map<String, dynamic> json) =>
    MissionResultEntity(
      totalCompletedMission: json['totalCompletedMission'] as int,
      totalRejectedMission: json['totalRejectedMission'] as int,
      completedMissions: (json['completedMissions'] as List<dynamic>)
          .map(
              (e) => CompletedMissionEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      rejectedMissions: (json['rejectedMissions'] as List<dynamic>)
          .map((e) => RejectedMissionEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MissionResultEntityToJson(
        MissionResultEntity instance) =>
    <String, dynamic>{
      'totalCompletedMission': instance.totalCompletedMission,
      'totalRejectedMission': instance.totalRejectedMission,
      'completedMissions':
          instance.completedMissions.map((e) => e.toJson()).toList(),
      'rejectedMissions':
          instance.rejectedMissions.map((e) => e.toJson()).toList(),
    };
