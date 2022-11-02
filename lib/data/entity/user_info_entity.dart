import 'package:json_annotation/json_annotation.dart';

part 'user_info_entity.g.dart';
@JsonSerializable()
class UserInfoEntity {

  String username;
  int rewardQuantity;

  UserInfoEntity({
    required this.username,
    required this.rewardQuantity,
  });

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) => _$UserInfoEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoEntityToJson(this);
}