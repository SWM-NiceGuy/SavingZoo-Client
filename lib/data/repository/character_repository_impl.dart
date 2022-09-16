import 'package:amond/data/source/network/api/character_api.dart';
import 'package:amond/domain/models/member_info.dart';
import 'package:amond/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  CharacterApi characterApi;
  CharacterRepositoryImpl(this.characterApi);

  @override

  /// 서버에서 경험치를 가져오는 함수
  ///
  /// 불러온 경험치값을 반환
  Future<int> changeExp(String provider, String uid, int exp) async {
    final resExp = await characterApi.changeExp(provider, uid, exp);
    return resExp;
  }

  @override

  /// 서버에서 경험치를 변경하는 함수
  ///
  /// 경험치 변경 후 결과값을 반환
  Future<int> getExp(String provider, String uid) async {
    final resExp = await characterApi.getExp(provider, uid);
    return resExp;
  }

  @override
  Future<String?> getName(MemberInfo me) async {
    final res = await characterApi.getName(me);
    return res;
  }

  @override
  Future<void> setName(MemberInfo me, String name) async {
    await characterApi.setName(me, name);
  }
}
