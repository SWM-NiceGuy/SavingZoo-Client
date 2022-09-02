import 'package:amond/data/repository/exp_repository_impl.dart';
import 'package:amond/data/repository/member_repository_impl.dart';
import 'package:amond/data/source/network/api/exp_api.dart';
import 'package:amond/data/source/network/api/member_api.dart';
import 'package:amond/domain/usecases/exp/exp_use_cases.dart';
import 'package:amond/domain/usecases/exp/get_exp.dart';
import 'package:amond/domain/usecases/member/member_use_cases.dart';
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
  Provider<ExpApi>(create: (_) => ExpApi()),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<MemberApi, MemberRepositoryImpl>(
      update: (_, api, __) => MemberRepositoryImpl(api)),
  ProxyProvider<ExpApi, ExpRepositoryImpl>(
    update: (_, api, __) => ExpRepositoryImpl(api),
  ),
  ProxyProvider<MemberRepositoryImpl, MemberUseCases>(
    update: (_, repository, __) => MemberUseCases(repository),
  ),
  ProxyProvider<ExpRepositoryImpl, ExpUseCases>(
    update: (_, repository, __) => ExpUseCases(
      changeExp: ChangeExp(repository),
      getExp: GetExp(repository),
    ),
  )
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider(create: (_) => GrowController()),
];
