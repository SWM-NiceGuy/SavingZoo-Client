import 'package:amond/data/entity/mission_detail_entity.dart';
import 'package:amond/domain/models/mission_state.dart';

class MissionDetail {
  String name;
  String content;
  String description;
  List<String> exampleImageUrls;
  String submitGuide;
  int reward;
  MissionState state;

  MissionDetail({
    required this.name,
    required this.description,
    required this.content,
    required this.submitGuide,
    required this.exampleImageUrls,
    required this.reward,
    required this.state,
  });

  factory MissionDetail.fromEntity(MissionDetailEntity entity) =>
      _$MissionDetailFromEntity(entity);

  MissionDetailEntity toEntity() => MissionDetailEntity(
      name: name,
      content: content,
      description: description,
      exampleImageUrls: exampleImageUrls,
      submitGuide: submitGuide,
      reward: reward,
      state: state.toString());

  static MissionDetail _$MissionDetailFromEntity(MissionDetailEntity entity) =>
      MissionDetail(
        name: entity.name,
        content: entity.content,
        description: entity.description,
        exampleImageUrls: entity.exampleImageUrls,
        submitGuide: entity.submitGuide,
        reward: entity.reward,
        state: MissionState.fromString(entity.state),
      );
}
