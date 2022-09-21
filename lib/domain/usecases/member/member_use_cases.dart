import 'package:amond/domain/usecases/member/resign.dart';
import 'package:amond/domain/usecases/member/login.dart';

class MemberUseCases {
  Resign resign;
  Login login;

  MemberUseCases({
    required this.resign,
    required this.login
  });
}
