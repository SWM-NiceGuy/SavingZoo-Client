// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grow_history_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrowHistoryEntity _$GrowHistoryEntityFromJson(Map<String, dynamic> json) =>
    GrowHistoryEntity(
      birthday: json['birthday'] as int,
      species: json['species'] as String,
      petName: json['petName'] as String,
      stages: (json['stages'] as List<dynamic>)
          .map((e) => GrowStageEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GrowHistoryEntityToJson(GrowHistoryEntity instance) =>
    <String, dynamic>{
      'birthday': instance.birthday,
      'species': instance.species,
      'petName': instance.petName,
      'stages': instance.stages.map((e) => e.toJson()).toList(),
    };
