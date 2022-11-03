import 'package:amond/presentation/controllers/grow/grow_view_model.dart';
import 'package:amond/presentation/screens/main_screen.dart';
import 'package:amond/presentation/screens/onboarding/onboarding1_screen.dart';
import 'package:amond/presentation/widget/platform_based_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Main Screen으로 갈지 Onboarding Screen으로 갈지 결정하는 widget
class MainOrOnboardingScreen extends StatelessWidget {
  const MainOrOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (await context.read<GrowViewModel>().checkIfCharacterHasName()) {
        _navigateToMainScreen(context);
      } else {
        _navigateToOnboardingScreen(context);
      }
    });

    return const Scaffold(
      body: Center(
        child: PlatformBasedLoadingIndicator(),
      ),
    );
  }

  void _navigateToMainScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => const MainScreen(),
            settings: const RouteSettings(name: "/")),
        (Route<dynamic> route) => false);
    // Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
  }

  void _navigateToOnboardingScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => const Onboarding1Screen(),
            settings: const RouteSettings(name: "/")),
        (Route<dynamic> route) => false);
    // Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
  }
}
