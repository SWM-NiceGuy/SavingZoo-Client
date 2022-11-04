import 'package:amond/data/entity/mission_history_entity.dart';
import 'package:amond/domain/models/mission_state.dart';

class MissionHistory {
  MissionState state;
  DateTime date;
  String type;
  String missionName;
  int reward;
  String? descriptionWhyRejected;

  MissionHistory({
    required this.state,
    required this.date,
    required this.type,
    required this.missionName,
    required this.reward,
    this.descriptionWhyRejected,
  });

  factory MissionHistory.fromEntity(MissionHistoryEntity entity) =>
      _$MissionHistoryFromEntity(entity);

  // MissionHistoryEntity toEntity() => MissionHistoryEntity();

  static MissionHistory _$MissionHistoryFromEntity(
          MissionHistoryEntity entity) =>
      MissionHistory(
        state: MissionState.fromString(entity.state),
        date: DateTime.fromMillisecondsSinceEpoch(entity.date),
        type: entity.rewardType,
        missionName: entity.title,
        reward: entity.reward,
      );
}
