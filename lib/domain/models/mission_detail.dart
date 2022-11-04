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
  String submitImageUrl;

  MissionDetail({
    required this.name,
    required this.description,
    required this.content,
    required this.submitGuide,
    required this.exampleImageUrls,
    required this.reward,
    required this.state,
    required this.submitImageUrl,
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
        state: state.toString(),
        submitImageUrl: submitImageUrl,
      );

  static MissionDetail _$MissionDetailFromEntity(MissionDetailEntity entity) =>
      MissionDetail(
        name: entity.name,
        content: entity.content,
        description: entity.description,
        exampleImageUrls: entity.exampleImageUrls,
        submitGuide: entity.submitGuide,
        reward: entity.reward,
        state: MissionState.fromString(entity.state),
        submitImageUrl: entity.submitImageUrl,
      );

  bool get canSubmit {
    return state == MissionState.incomplete || state == MissionState.rejected;
  }
}
