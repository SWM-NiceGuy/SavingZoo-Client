// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberEntity _$MemberEntityFromJson(Map<String, dynamic> json) => MemberEntity(
      provider: json['provider'] as String,
      uid: json['uid'] as String,
      nickname: json['nickname'] as String?,
      gender: json['gender'] as String?,
      ageGroup: json['ageGroup'] as int?,
    );

Map<String, dynamic> _$MemberEntityToJson(MemberEntity instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'uid': instance.uid,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'ageGroup': instance.ageGroup,
    };
