import 'package:amond/presentation/controllers/grow/grow_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class StageUpEffect extends StatelessWidget {
  const StageUpEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final effectVisible =
        context.select<GrowViewModel, bool>((value) => value.levelUpEffect);

    return effectVisible
        ? Lottie.asset(
            'assets/lotties/lottie_levelup.json',
             frameRate: FrameRate.max,
            repeat: false,
            width: deviceSize.width * 0.4,
            fit: BoxFit.cover,
            // onLoaded: (comp) {
            //   comp..duration
            // }
          )
        : const SizedBox();
  }
}
