import 'package:amond/data/entity/user_info_entity.dart';

class UserInfo {
  String userName;
  int goodsQuantity;

  UserInfo({
    required this.userName,
    required this.goodsQuantity,
  });

  factory UserInfo.fromEntity(UserInfoEntity entity) =>
      _$UserInfoFromEntity(entity);

  static UserInfo _$UserInfoFromEntity(UserInfoEntity entity) => UserInfo(
        userName: entity.username,
        goodsQuantity: entity.rewardQuantity,
      );
}
