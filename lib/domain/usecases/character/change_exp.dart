import 'package:amond/domain/repositories/character_repository.dart';

class ChangeExp {
  CharacterRepository expRepository;
  ChangeExp(this.expRepository);

  Future<int> call(int exp) async {
    final resExp = await expRepository.changeExp(exp);
    return resExp;
  }
}