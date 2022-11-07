import 'package:amond/domain/repositories/character_repository.dart';

class SetName {
  CharacterRepository repository;
  SetName(this.repository);

  Future<void> call(int petId, String name) async {
    await repository.setName(petId, name);
  }
}
