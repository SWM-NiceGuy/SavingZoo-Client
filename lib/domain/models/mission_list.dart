import 'package:amond/data/entity/mission_list_entity.dart';
import 'package:amond/domain/models/mission_state.dart';

class MissionList {
  int id;
  String name;
  String category;
  String iconUrl;
  MissionState state;
  int reward;

  MissionList(
      {required this.id,
      required this.name,
      required this.category,
      required this.iconUrl,
      required this.state,
      required this.reward});

  factory MissionList.fromEntity(MissionListEntity entity) =>
      _$MissionListFromEntity(entity);

  MissionListEntity toEntity() => MissionListEntity(
        id: id,
        name: name,
        category: category,
        iconUrl: iconUrl,
        state: state.toString(),
        reward: reward,
      );

  static MissionList _$MissionListFromEntity(MissionListEntity entity) =>
      MissionList(
          id: entity.id,
          name: entity.name,
          category: entity.category,
          iconUrl: entity.iconUrl,
          state: MissionState.fromString(entity.state),
          reward: entity.reward);
}
