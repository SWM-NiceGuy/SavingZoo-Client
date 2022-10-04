enum MissionState {
  incomplete,
  wait,
  completed,
  rejected,
}

MissionState stringToMissionState(String value) {
  switch (value) {
    case 'INCOMPLETE':
      return MissionState.incomplete;
    case 'WAIT':
      return MissionState.wait;
    case 'COMPLETED':
      return MissionState.completed;
    case 'REJECTED':
      return MissionState.rejected;
    default:
      throw Exception('MissionState로의 변환이 불가합니다.');
  }
}
