abstract class ExpRepository {
  Future<int> getExp(String provider, String uid);
  Future<int> changeExp(String provider, String uid, int exp);
  Future<int> getMissionCompleted(String provider, String uid);
  Future<void> changeMissionCompleted(String provider, String uid, int value);
}