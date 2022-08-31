import 'package:json_annotation/json_annotation.dart';

part 'member_entity.g.dart';

@JsonSerializable()
class MemberEntity {
  // provider, email, nickname, gender, age
  final String provider;
  final String uid;
  final String? nickname;
  final String? gender;
  final int? ageGroup;

  MemberEntity({
    required this.provider,
    required this.uid,
    this.nickname,
    this.gender,
    this.ageGroup
  });


  factory MemberEntity.fromJson(Map<String, dynamic> json) => _$MemberEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MemberEntityToJson(this);
}