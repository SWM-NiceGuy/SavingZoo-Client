import 'package:amond/data/source/network/api/exp_api.dart';
import 'package:amond/domain/repositories/exp_repository.dart';

class ExpRepositoryImpl implements ExpRepository {
  ExpApi expApi;
  ExpRepositoryImpl(this.expApi);

  @override

  /// 서버에서 경험치를 가져오는 함수
  ///
  /// 불러온 경험치값을 반환
  Future<int> changeExp(String provider, String uid, int exp) async {
    final resExp = await expApi.changeExp(provider, uid, exp);
    return resExp;
  }

  @override

  /// 서버에서 경험치를 변경하는 함수
  ///
  /// 경험치 변경 후 결과값을 반환
  Future<int> getExp(String provider, String uid) async {
    final resExp = await expApi.getExp(provider, uid);
    return resExp;
  }

  @override
  Future<int> getMissionCompleted(String provider, String uid) async {
    final resMission = await expApi.getMissionCompleted(provider, uid);
    return resMission;
  }

  @override
  Future<void> changeMissionCompleted(
      String provider, String uid, int value) async {
        await expApi.changeMissionCompleted(provider, uid, value);
      }
}
