import 'package:amond/domain/repositories/exp_repository.dart';

class GetMissionCompleted {
  ExpRepository expRepository;
  GetMissionCompleted(this.expRepository);

  Future<int> call(String provider, String uid) async {
    return await expRepository.getMissionCompleted(provider, uid);
  }
}