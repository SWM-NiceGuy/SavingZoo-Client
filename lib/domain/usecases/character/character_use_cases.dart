import 'package:amond/domain/usecases/character/change_exp.dart';
import 'package:amond/domain/usecases/character/get_exp.dart';
import 'package:amond/domain/usecases/character/get_name.dart';
import 'package:amond/domain/usecases/character/set_name.dart';

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
