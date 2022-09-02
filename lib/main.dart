import 'package:amond/di/provider_setup.dart';
import 'package:amond/presentation/screens/main_screen.dart';
import 'package:amond/presentation/screens/qr_scanner.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


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
    final themeData = ThemeData(
      textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: blackColor)),
      primarySwatch: primarySwatch,
      brightness: Brightness.light,
    );
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      darkTheme: themeData,
      home: const MainScreen(),
      routes: {
        MainScreen.routeName: (context) => const MainScreen(),
        QrScanner.routeName: (context) => const QrScanner(),
      },
    );
  }
}