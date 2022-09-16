import 'package:amond/widget/platform_based_indicator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: PlatformBasedIndicator()),
    );
  }
}
