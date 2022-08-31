import 'package:amond/domain/repositories/exp_repository.dart';

class GetExp {
  ExpRepository expRepository;
  GetExp(this.expRepository);

  Future<int> call(String provider, String uid) async {
    final resExp = await expRepository.getExp(provider, uid);
    return resExp;
  }
}