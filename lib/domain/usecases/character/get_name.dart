import 'package:amond/domain/models/member_info.dart';
import 'package:amond/domain/repositories/character_repository.dart';

class GetName {
  CharacterRepository repository;
  GetName(this.repository);

  Future<String?> call(MemberInfo me) async {
    final String? name = await repository.getName(me);
    return name;
  }
}