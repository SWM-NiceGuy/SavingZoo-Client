import 'package:amond/data/entity/mission_list_entity.dart';

class MissionList {
  int id;
  String name;
  String iconUrl;
  String state;

  MissionList({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.state,
  });

  factory MissionList.fromEntity(MissionListEntity entity) =>
      _$MissionListFromEntity(entity);

  MissionListEntity toEntity() => MissionListEntity(
        id: id,
        name: name,
        iconUrl: iconUrl,
        state: state,
      );

  static MissionList _$MissionListFromEntity(MissionListEntity entity) =>
      MissionList(
        id: entity.id,
        name: entity.name,
        iconUrl: entity.iconUrl,
        state: entity.state,
      );
}
