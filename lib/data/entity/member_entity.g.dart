// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberEntity _$MemberEntityFromJson(Map<String, dynamic> json) => MemberEntity(
      provider: json['provider'] as String,
      uid: json['uid'] as String,
      nickname: json['nickname'] as String?,
      genderGroup: json['genderGroup'] as String?,
      age: json['age'] as int?,
    );

Map<String, dynamic> _$MemberEntityToJson(MemberEntity instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'uid': instance.uid,
      'nickname': instance.nickname,
      'genderGroup': instance.genderGroup,
      'age': instance.age,
    };
