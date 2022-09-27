abstract class CharacterRepository {
  Future<int> getExp();
  Future<int> changeExp(int exp);
  Future<String?> getName();
  Future<void> setName(String name);
}
