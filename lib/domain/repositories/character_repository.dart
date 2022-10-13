import 'package:amond/domain/models/character.dart';

abstract class CharacterRepository {
  Future<int> getExp();
  Future<int> changeExp(int exp);
  Future<String?> getName();
  Future<Character> getCharacter();
  Future<void> setName(int petId, String name);
  Future<Character?> playWithCharacter(int petId);
}
