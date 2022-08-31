// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberEntity _$MemberEntityFromJson(Map<String, dynamic> json) => MemberEntity(
      provider: json['provider'] as String,
      uid: json['email'] as String,
      nickname: json['nickname'] as String?,
      gender: json['gender'] as String?,
      age: json['age'] as int?,
    );

Map<String, dynamic> _$MemberEntityToJson(MemberEntity instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'email': instance.uid,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'age': instance.age,
    };
