import 'package:amond/domain/repositories/character_repository.dart';

class GetName {
  CharacterRepository repository;
  GetName(this.repository);

  Future<String?> call() async {
    final String? name = await repository.getName();
    return name;
  }
}
