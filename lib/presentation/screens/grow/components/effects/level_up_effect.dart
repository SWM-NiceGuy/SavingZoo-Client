import 'package:amond/presentation/controllers/grow_controller.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LevelUpEffect extends StatelessWidget {
  const LevelUpEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectVisible =
        context.select<GrowController, bool>((value) => value.levelUpEffect);

    return effectVisible
        ? Lottie.asset(
            'assets/lotties/lottie-levelup.json',
            repeat: false,
          )
        : const SizedBox();
  }
}
