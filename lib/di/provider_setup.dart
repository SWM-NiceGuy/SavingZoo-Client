import 'package:amond/data/repository/banner_repository_impl.dart';
import 'package:amond/data/repository/character_repository_impl.dart';
import 'package:amond/data/repository/member_repository_impl.dart';
import 'package:amond/data/repository/mission_repository_impl.dart';
import 'package:amond/data/source/network/api/banner_api.dart';
import 'package:amond/data/source/network/api/character_api.dart';
import 'package:amond/data/source/network/api/member_api.dart';
import 'package:amond/data/source/network/api/mission_api.dart';
import 'package:amond/domain/usecases/member/member_use_cases.dart';
import 'package:amond/domain/usecases/member/resign.dart';
import 'package:amond/domain/usecases/member/login.dart';
import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/controllers/banner_view_model.dart';

import 'package:amond/presentation/controllers/main_view_model.dart';

import 'package:amond/utils/auth/do_apple_auth.dart';
import 'package:amond/utils/auth/do_auth.dart';
import 'package:amond/utils/auth/do_kakao_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  Provider<MemberApi>(create: (_) => MemberApi()),
  Provider<CharacterApi>(create: (_) => CharacterApi()),
  Provider<MissionApi>(create: (_) => MissionApi()),
  Provider<BannerApi>(create: (_) => BannerApi()),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<MemberApi, MemberRepositoryImpl>(
      update: (_, api, __) => MemberRepositoryImpl(api)),

  ProxyProvider<CharacterApi, CharacterRepositoryImpl>(
    update: (_, api, __) => CharacterRepositoryImpl(api),
  ),
  ProxyProvider<MissionApi, MissionRepositoryImpl>(
    update: (_, api, __) => MissionRepositoryImpl(api),
  ),
  ProxyProvider<MemberRepositoryImpl, MemberUseCases>(
    update: (_, repository, __) => MemberUseCases(
      resign: Resign(repository),
      login: Login(repository),
    ),
  ),
  ProxyProvider<BannerApi, BannerRepositoryImpl>(
      update: (_, api, __) => BannerRepositoryImpl(api)),
  // ProxyProvider<CharacterRepositoryImpl, CharacterUseCases>(
  //   update: (_, repository, __) => CharacterUseCases(
  //     changeExp: ChangeExp(repository),
  //     getExp: GetExp(repository),
  //     setName: SetName(repository),
  //     getName: GetName(repository),
  //   ),
  // )
];

List<SingleChildWidget> viewModels = [
  // AuthController
  ChangeNotifierProvider<AuthController>(
    create: (_) => AuthController(_.read<MemberUseCases>()),
  ),

  // MainViewModel
  ChangeNotifierProvider(
    create: (_) => MainViewModel(),
  ),

  // BannerViewModel
  ChangeNotifierProvider(
      create: (_) => BannerViewModel(_.read<BannerRepositoryImpl>())),

  // 회원탈퇴 DI
  ProxyProvider<AuthController, DoAuth>(
    create: (context) {
      final loginType = context.read<AuthController>().loginType;
      switch (loginType) {
        case "KAKAO":
          return DoKakaoAuth();
        case "APPLE":
          return DoAppleAuth();
      }
      throw Exception('로그인 타입이 지정되지 않았습니다.');
    },
    update: (context, value, previous) {
      final loginType = context.read<AuthController>().loginType;
      switch (loginType) {
        case "KAKAO":
          return DoKakaoAuth();
        case "APPLE":
          return DoAppleAuth();
      }
      throw Exception('로그인 타입이 지정되지 않았습니다.');
    },
  )
];
