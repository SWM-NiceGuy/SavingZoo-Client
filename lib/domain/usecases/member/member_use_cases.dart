import 'package:amond/domain/usecases/member/change_user_name.dart';
import 'package:amond/domain/usecases/member/get_goods_quantity.dart';
import 'package:amond/domain/usecases/member/get_user_name.dart';
import 'package:amond/domain/usecases/member/resign.dart';
import 'package:amond/domain/usecases/member/login.dart';

class MemberUseCases {
  Resign resign;
  Login login;
  GetUserName getUserName;
  ChangeUserName changeUserName;
  GetGoodsQuantity getGoodsQuantity;

  MemberUseCases({
    required this.resign,
    required this.login,
    required this.getUserName,
    required this.changeUserName,
    required this.getGoodsQuantity,
  });
}
