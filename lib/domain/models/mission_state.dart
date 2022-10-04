enum MissionState {
  incomplete,
  wait,
  completed,
  rejected;

  static MissionState fromString(String value) {
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

  @override
  String toString() {
    return name.toUpperCase();
  }
}
