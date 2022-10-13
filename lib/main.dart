import 'package:amond/di/provider_setup.dart';
import 'package:amond/presentation/controllers/auth_controller.dart';

import 'package:amond/presentation/screens/auth/auth_screen.dart';
import 'package:amond/presentation/screens/main_screen.dart';
import 'package:amond/presentation/screens/mission/mission_detail_screen.dart';
import 'package:amond/presentation/screens/mission/mission_history_screen.dart';
import 'package:amond/presentation/screens/mission/mission_screen.dart';
import 'package:amond/presentation/screens/please_update_screen.dart';
import 'package:amond/presentation/screens/qr_scanner.dart';
import 'package:amond/presentation/screens/settings/settings_screen.dart';
import 'package:amond/presentation/screens/splash_screen.dart';
import 'package:amond/secrets/secret.dart';
import 'package:amond/ui/colors.dart';
import 'package:amond/utils/push_notification.dart';

import 'package:amond/utils/version/app_version.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_common.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  if (!kDebugMode) {
    // Firebase Analytics 추가
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // Firebase Crashlytics 추가
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  // 로컬 데이터 삭제
  // SharedPreferences.getInstance().then((value) => value.clear());

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  KakaoSdk.init(nativeAppKey: kakaoNativeAppKey);

  // 앱 버전 체크
  final bool isLatest = await isLatestVersion();

  // foreground 푸시 알림 설정
  await setUpForegroundNotification();


  runApp(MultiProvider(
    providers: globalProviders,
    child: MyApp(isLatest: isLatest),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isLatest}) : super(key: key);
  final bool isLatest;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 파이어베이스 메시지
    return MaterialApp(
      title: '아몬드',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme.apply(bodyColor: blackColor)),
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: backgroundColor,
          )),

      /// 앱 시작시 setToken을 통해, 자동로그인 시도
      /// 반환된 값이 [true]라면 MainScreen으로 이동
      /// 반환된 값이 [false]라면 AuthScreen으로 이동
      home: isLatest
          ? FutureBuilder(
              future: context.read<AuthController>().setToken(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? snapshot.data.toString() == 'true'
                        ? const MainScreen()
                        : const AuthScreen()
                    : const SplashScreen();
              } // 사용하려면 Future.delayed 필요
              ,
            )
          // 앱이 최신버전이 아니라면 업데이트 해달라고 요청
          : const PleaseUpdateScreen(),
      routes: {
        AuthScreen.routeName: (context) => const AuthScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
        QrScanner.routeName: (context) => const QrScanner(),
        MissionScreen.routeName: (context) => const MissionScreen(),
        MissionDetailScreen.routeName: (context) => const MissionDetailScreen(),
        MissionHistoryScreen.routeName: (context) =>
            const MissionHistoryScreen(),
        SettingsScreen.routeName: (context) => const SettingsScreen(),
      },
    );
  }
}

//  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
