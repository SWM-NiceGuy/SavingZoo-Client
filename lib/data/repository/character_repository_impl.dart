import 'package:amond/data/source/network/api/character_api.dart';
import 'package:amond/domain/models/character.dart';
import 'package:amond/domain/models/grow_history.dart';
import 'package:amond/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  CharacterApi characterApi;
  CharacterRepositoryImpl(this.characterApi);

  @override

  /// 서버에서 경험치를 가져오는 함수
  ///
  /// 불러온 경험치값을 반환
  Future<int> changeExp(int exp) async {
    final resExp = await characterApi.changeExp(exp);
    return resExp;
  }

  @override

  /// 서버에서 경험치를 변경하는 함수
  ///
  /// 경험치 변경 후 결과값을 반환
  Future<int> getExp() async {
    final resExp = await characterApi.getExp();
    return resExp;
  }

  @override
  Future<String?> getName() async {
    final res = await characterApi.getName();
    return res;
  }

  @override
  Future<void> setName(int petId, String name) async {
    await characterApi.setName(petId, name);
  }

  @override
  Future<Character> getCharacter() async {
    try {
      final characterEntity = await characterApi.getCharacterInfo();
      return Character.fromEntity(characterEntity);
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<Character?> playWithCharacter(int petId) async {
    final resultCharacterEntity = await characterApi.getPlayResult(petId);
    if (resultCharacterEntity == null) {
      return null;
    }

    return Character.fromEntity(resultCharacterEntity);
  }

  @override
  Future<GrowHistory> getGrowHistory() {
    // TODO: implement getGrowHistory
    throw UnimplementedError();
  }
}
