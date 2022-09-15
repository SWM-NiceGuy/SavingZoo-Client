import 'package:amond/data/entity/member_entity.dart';
import 'package:amond/domain/models/member_info.dart';
import 'package:amond/domain/repositories/character_repository.dart';

class SetName {
  CharacterRepository repository;
  SetName(this.repository);

  Future<void> call(MemberInfo me, String name) async {
    await repository.setName(me, name);
  }
}