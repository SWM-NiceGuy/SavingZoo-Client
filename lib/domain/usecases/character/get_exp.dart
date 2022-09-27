import 'package:amond/domain/repositories/character_repository.dart';

class GetExp {
  CharacterRepository expRepository;
  GetExp(this.expRepository);

  Future<int> call() async {
    final resExp = await expRepository.getExp();
    return resExp;
  }
}