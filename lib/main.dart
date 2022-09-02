import 'package:amond/di/provider_setup.dart';
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

  // await Firebase.initializeApp();
  // KakaoSdk.init(nativeAppKey: kakaoNativeAppKey);

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: const MainScreen(),
      routes: {
        MainScreen.routeName: (context) => const MainScreen(),
        QrScanner.routeName: (context) => const QrScanner(),
      },
    );
  }
}
