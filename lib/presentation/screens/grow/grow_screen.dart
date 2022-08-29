import 'package:amond/presentation/controllers/grow_controller.dart';
import 'package:amond/presentation/screens/grow/components/level_system.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GrowScreen extends StatelessWidget {
  const GrowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainController = context.watch<GrowController>();
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        LevelSystem(
          width: width,
          height: 12.0,
          currentExp: mainController.currentExp,
          maxExp: mainController.maxExp,
          percentage: mainController.expPercentage,
        ),
        const SizedBox(height: 24.0),
        Align(
          child: ElevatedButton(
            onPressed: () => mainController.increaseExp(10),
            style: ElevatedButton.styleFrom(primary: expBarColor1),
            child: const Center(child: Text('성장포인트 10 증가')),
          ),
        ),
      ],
    );
  }
}
