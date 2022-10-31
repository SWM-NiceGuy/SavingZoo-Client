import 'package:amond/domain/models/mission_detail.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AmondFirebaseAnalytics {
  static void logEvent(FaEvent event) {
    FirebaseAnalytics.instance.logEvent(name: event.name);
  }

  static void logMissionEvent({
    required FaEvent event,
    required int missionId,
    required MissionDetail missionDetail,
  }) {
    FirebaseAnalytics.instance.logEvent(
      name: event.name,
      parameters: {
        '미션id': missionId,
        '미션이름': missionDetail.name,
        '상태': missionDetail.state.toString(),
        '보상': missionDetail.reward,
      },
    );
  }
}

enum FaEvent {
  touchMissionButton('미션_인증_터치'),
  cancelMission('미션_인증_취소'),
  executeMission('미션_인증_제출');

  const FaEvent(this.name);

  final String name;
}
