import 'package:amond/domain/usecases/member/change_user_name.dart';
import 'package:amond/domain/usecases/member/get_user_name.dart';
import 'package:amond/domain/usecases/member/resign.dart';
import 'package:amond/domain/usecases/member/login.dart';

class MemberUseCases {
  Resign resign;
  Login login;
  GetUserName getUserName;
  ChangeUserName changeUserName;

  MemberUseCases({
    required this.resign,
    required this.login,
    required this.getUserName,
    required this.changeUserName,
  });
}
