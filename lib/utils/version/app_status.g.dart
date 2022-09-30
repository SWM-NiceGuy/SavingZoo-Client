// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppStatus _$AppStatusFromJson(Map<String, dynamic> json) => AppStatus(
      latestVersion: json['latestVersion'] as String,
      releaseNote: json['releaseNote'] as String,
      required: json['required'] as bool,
    );

Map<String, dynamic> _$AppStatusToJson(AppStatus instance) => <String, dynamic>{
      'required': instance.required,
      'latestVersion': instance.latestVersion,
      'releaseNote': instance.releaseNote,
    };
