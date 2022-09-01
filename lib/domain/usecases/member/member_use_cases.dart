import 'package:amond/domain/usecases/member/resign.dart';
import 'package:amond/domain/usecases/member/sign_up.dart';

class MemberUseCases {
  Resign resign;
  SignUp signUp;

  MemberUseCases({
    required this.resign,
    required this.signUp
  });
}
