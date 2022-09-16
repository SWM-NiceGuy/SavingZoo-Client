import 'package:amond/domain/repositories/character_repository.dart';

class ChangeExp {
  CharacterRepository expRepository;
  ChangeExp(this.expRepository);

  Future<int> call(String provider, String uid, int exp) async {
    final resExp = await expRepository.changeExp(provider, uid, exp);
    return resExp;
  }
}