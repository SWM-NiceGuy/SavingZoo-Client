import 'package:amond/domain/usecases/exp/change_exp.dart';
import 'package:amond/domain/usecases/exp/get_exp.dart';
import 'package:amond/domain/usecases/exp/get_name.dart';
import 'package:amond/domain/usecases/exp/set_name.dart';

class CharacterUseCases {
  ChangeExp changeExp;
  GetExp getExp;
  GetName getName;
  SetName setName;

  CharacterUseCases({
    required this.changeExp,
    required this.getExp,
    required this.getName,
    required this.setName,
  });
}
