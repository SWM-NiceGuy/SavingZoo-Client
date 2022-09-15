import 'package:amond/domain/usecases/exp/change_exp.dart';
import 'package:amond/domain/usecases/exp/get_exp.dart';

class ExpUseCases {
  ChangeExp changeExp;
  GetExp getExp;

  ExpUseCases({
    required this.changeExp,
    required this.getExp,
  });
}
