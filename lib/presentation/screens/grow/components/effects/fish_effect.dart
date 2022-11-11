import 'package:amond/presentation/controllers/grow/grow_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FishEffect extends StatelessWidget {
  const FishEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final isHeartVisible =
        context.select<GrowViewModel, bool>((value) => value.fishEffect);
        
    return isHeartVisible
        ? Lottie.asset(
            'assets/lotties/fish_effect.json',
            frameRate: FrameRate.max,
            repeat: false,
            fit: BoxFit.cover,
            width: deviceSize.width * 0.6,
          )
        : const SizedBox();
  }
}
