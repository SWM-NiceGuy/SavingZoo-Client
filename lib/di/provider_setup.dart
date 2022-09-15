import 'package:amond/data/repository/character_repository_impl.dart';
import 'package:amond/data/repository/member_repository_impl.dart';
import 'package:amond/data/source/network/api/character_api.dart';
import 'package:amond/data/source/network/api/member_api.dart';
import 'package:amond/domain/usecases/exp/character_use_cases.dart';
import 'package:amond/domain/usecases/exp/get_exp.dart';
import 'package:amond/domain/usecases/exp/get_name.dart';
import 'package:amond/domain/usecases/exp/set_name.dart';
import 'package:amond/domain/usecases/member/member_use_cases.dart';
import 'package:amond/domain/usecases/member/resign.dart';
import 'package:amond/domain/usecases/member/sign_up.dart';
import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/controllers/grow_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../domain/usecases/exp/change_exp.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  Provider<MemberApi>(create: (_) => MemberApi()),
  Provider<CharacterApi>(create: (_) => CharacterApi()),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<MemberApi, MemberRepositoryImpl>(
      update: (_, api, __) => MemberRepositoryImpl(api)),
  ProxyProvider<CharacterApi, CharacterRepositoryImpl>(
    update: (_, api, __) => CharacterRepositoryImpl(api),
  ),
  ProxyProvider<MemberRepositoryImpl, MemberUseCases>(
    update: (_, repository, __) => MemberUseCases(
      resign: Resign(repository),
      signUp: SignUp(repository),
    ),
  ),
  ProxyProvider<CharacterRepositoryImpl, CharacterUseCases>(
    update: (_, repository, __) => CharacterUseCases(
      changeExp: ChangeExp(repository),
      getExp: GetExp(repository),
      setName: SetName(repository),
      getName: GetName(repository),
    ),
  )
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<AuthController>(
      create: (_) => AuthController(_.read<MemberUseCases>())),
  ChangeNotifierProxyProvider<AuthController, GrowController>(
    create: (context) => GrowController(context.read<CharacterUseCases>(), context.read<AuthController>().memberInfo!),
    update: (context, authController, previous) => GrowController(context.read<CharacterUseCases>(), authController.memberInfo!),
  )
];
