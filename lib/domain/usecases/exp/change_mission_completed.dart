import 'package:amond/domain/repositories/exp_repository.dart';

class ChangeMissionCompleted {
  ExpRepository expRepository;
  ChangeMissionCompleted(this.expRepository);

  Future<void> call(String provider, String uid, int value) async {
    await expRepository.changeMissionCompleted(provider, uid, value);
  }
}