enum RewardType {
  fish;

  static RewardType fromString(String value) {
    switch (value) {
      case 'FISH':
        return RewardType.fish;
      default:
        throw Exception('MissionState로의 변환이 불가합니다.');
    }
  }

  @override
  String toString() {
    return name.toUpperCase();
  }
}