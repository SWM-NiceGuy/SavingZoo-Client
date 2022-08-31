import 'package:amond/domain/repositories/exp_repository.dart';

class ChangeExp {
  ExpRepository expRepository;
  ChangeExp(this.expRepository);

  Future<int> call(String provider, String uid, int exp) async {
    final resExp = await expRepository.changeExp(provider, uid, exp);
    return resExp;
  }
}