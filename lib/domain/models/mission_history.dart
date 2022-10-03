import 'package:amond/domain/models/mission_state.dart';

class MissionHistory {
  MissionState state;
  DateTime date;
  String type;
  String missionName;
  int reward;

  MissionHistory({
    required this.state,
    required this.date,
    required this.type,
    required this.missionName,
    required this.reward,
  });
}