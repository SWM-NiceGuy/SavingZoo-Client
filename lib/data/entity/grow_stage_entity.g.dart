// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grow_stage_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrowStageEntity _$GrowStageEntityFromJson(Map<String, dynamic> json) =>
    GrowStageEntity(
      stage: json['stage'] as int,
      growState: json['growState'] as bool,
      description: json['description'] as String,
      level: json['level'] as int,
      weight: json['weight'] as String,
      height: json['height'] as String,
      grownDate: json['grownDate'] as int,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$GrowStageEntityToJson(GrowStageEntity instance) =>
    <String, dynamic>{
      'growState': instance.growState,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'stage': instance.stage,
      'level': instance.level,
      'weight': instance.weight,
      'height': instance.height,
      'grownDate': instance.grownDate,
    };
