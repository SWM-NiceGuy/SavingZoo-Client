import 'package:amond/domain/repositories/character_repository.dart';

class SetName {
  CharacterRepository repository;
  SetName(this.repository);

  Future<void> call(String name) async {
    await repository.setName(name);
  }
}
