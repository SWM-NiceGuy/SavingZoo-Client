import 'package:amond/domain/usecases/exp/change_exp.dart';
import 'package:amond/domain/usecases/exp/change_mission_completed.dart';
import 'package:amond/domain/usecases/exp/get_exp.dart';
import 'package:amond/domain/usecases/exp/get_mission_completed.dart';

class ExpUseCases {
  ChangeExp changeExp;
  GetExp getExp;
  GetMissionCompleted getMissionCompleted;
  ChangeMissionCompleted changeMissionCompleted;

  ExpUseCases({
    required this.changeExp,
    required this.getExp,
    required this.getMissionCompleted,
    required this.changeMissionCompleted,
  });
}
