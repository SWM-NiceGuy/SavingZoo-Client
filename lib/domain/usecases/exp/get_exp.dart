import 'package:amond/domain/repositories/character_repository.dart';

class GetExp {
  CharacterRepository expRepository;
  GetExp(this.expRepository);

  Future<int> call(String provider, String uid) async {
    final resExp = await expRepository.getExp(provider, uid);
    return resExp;
  }
}