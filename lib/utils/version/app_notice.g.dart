// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppNotice _$AppNoticeFromJson(Map<String, dynamic> json) => AppNotice(
      isApply: json['isApply'] as bool,
      isRequired: json['isRequired'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AppNoticeToJson(AppNotice instance) => <String, dynamic>{
      'isApply': instance.isApply,
      'isRequired': instance.isRequired,
      'message': instance.message,
    };
