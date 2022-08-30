import 'package:amond/presentation/controllers/grow_controller.dart';
import 'package:amond/presentation/screens/grow/components/level_system.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GrowScreen extends StatelessWidget {
  const GrowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final growController = context.watch<GrowController>();
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        LevelSystem(
          width: width,
          height: 12.0,
          level: growController.level,
          currentExp: growController.currentExp,
          maxExp: growController.maxExp,
          percentage: growController.expPercentage,
        ),
        const SizedBox(height: 24.0),
        AnimatedOpacity(
          opacity: growController.avatarIsVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: growController.fadeDuration),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset(
              growController.avatarPath,
              height: 180.0,
            ),
          ),
        ),
        const SizedBox(height: 24.0),
        Align(
          child: ElevatedButton(
            onPressed: () => growController.increaseExp(10),
            style: ElevatedButton.styleFrom(primary: expBarColor1),
            child: const Center(child: Text('성장포인트 10 증가')),
          ),
        ),
      ],
    );
  }
}
