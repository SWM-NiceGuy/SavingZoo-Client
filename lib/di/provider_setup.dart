import 'package:amond/data/repository/member_repository_impl.dart';
import 'package:amond/data/source/network/api/member_api.dart';
import 'package:amond/domain/repositories/member_repository.dart';
import 'package:amond/domain/usecases/member/member_use_cases.dart';
import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  Provider(create: (_) => MemberApi()),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<MemberApi, MemberRepositoryImpl>(
      update: (_, api, __) => MemberRepositoryImpl(api)),
  ProxyProvider<MemberRepositoryImpl, MemberUseCases>(
    update: (_, repository, __) => MemberUseCases(repository),
  )
];

List<SingleChildWidget> viewModels = [
 Provider<AuthController>(create: (_) => AuthController(_.read<MemberUseCases>())),
];
