import 'package:amond/presentation/controllers/grow/grow_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class StarfallEffect extends StatelessWidget {
  const StarfallEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final characterLevel =
        context.select<GrowViewModel, int>((value) => value.character.level);

    return characterLevel >= 5
        ? Lottie.asset(
            'assets/lotties/maxlevel-starfall.json',
            repeat: true,
          )
        : const SizedBox();
  }
}
