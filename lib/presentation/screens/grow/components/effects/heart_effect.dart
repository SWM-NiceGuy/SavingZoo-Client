import 'package:amond/presentation/controllers/grow/grow_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HeartEffect extends StatelessWidget {
  const HeartEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isHeartVisible =
        context.select<GrowViewModel, bool>((value) => value.isHeartVisible);
        
    return isHeartVisible
        ? Lottie.asset(
            'assets/lotties/lottie-hearts.json',
            repeat: false,
          )
        : const SizedBox();
  }
}
