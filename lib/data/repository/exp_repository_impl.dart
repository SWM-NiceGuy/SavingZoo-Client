
import 'package:amond/data/source/network/api/exp_api.dart';
import 'package:amond/domain/repositories/exp_repository.dart';

class ExpRepositoryImpl implements ExpRepository {
  ExpApi expApi;
  ExpRepositoryImpl(this.expApi);

  @override
  Future<int> changeExp(String provider, String uid, int exp) async {
    final resExp = await expApi.changeExp(provider, uid, exp);
    return resExp;
  }

  @override
  Future<int> getExp(String provider, String uid) async {
    final resExp = await expApi.getExp(provider, uid);
    return resExp;
  }

}