import 'package:amond/di/provider_setup.dart';
import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/screens/auth/auth_screen.dart';
import 'package:amond/presentation/screens/main_screen.dart';
import 'package:amond/presentation/screens/qr_scanner.dart';
import 'package:amond/presentation/screens/splash_screen.dart';
import 'package:amond/secrets/secret.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_common.dart';
import 'package:provider/provider.dart';

import 'utils/apple_client_secret.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  KakaoSdk.init(nativeAppKey: kakaoNativeAppKey);

  runApp(MultiProvider(
    providers: globalProviders,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authController = context.read<AuthController>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      /// 앱 시작시 setToken을 통해, 자동로그인 시도
      /// 반환된 값이 [true]라면 MainScreen으로 이동
      /// 반환된 값이 [false]라면 AuthScreen으로 이동
      home: FutureBuilder(
              future: authController.setToken(),
              builder: (context, snapshot) =>
                snapshot.hasData
                 ? snapshot.data.toString() == 'true' ? const MainScreen() : const AuthScreen()
                 : const SplashScreen() // 사용하려면 Future.delayed 필요
              ,
            ),
      routes: {
        AuthScreen.routeName: (context) => const AuthScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
        QrScanner.routeName: (context) => const QrScanner(),
      },
    );
  }
}
