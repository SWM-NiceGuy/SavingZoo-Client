import 'package:amond/presentation/controllers/grow_controller.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';

class LevelWidget extends StatelessWidget {
  const LevelWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final character = context.watch<GrowController>().character;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8.0, 24, 0.0),
      child: _LevelSystem(
        height: 12.0,
        level: character.level,
        currentExp: character.currentExp,
        maxExp: character.maxExp,
        percentage: character.expPct,
      ),
    );
  }
}

class _LevelSystem extends StatelessWidget {
  final double height;
  final int level;
  final int currentExp;
  final int maxExp;
  final double percentage;

  const _LevelSystem({
    required this.height,
    required this.level,
    required this.currentExp,
    required this.maxExp,
    required this.percentage,
    Key? key,
  }) : super(key: key);

  final levelTextStyle = const TextStyle(
    fontSize: 36.0,
    fontWeight: FontWeight.w500,
    color: kBlue,
  );
  final bodyTextStyle = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: kBlue,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(level.toString(), style: levelTextStyle),
        const SizedBox(width: 12.0),
        Flexible(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('Level', style: bodyTextStyle),
                  Text('$currentExp / $maxExp', style: bodyTextStyle),
                ],
              ),
              const SizedBox(height: 5.0),
              _ExpBar(height: height, percentage: percentage),
            ],
          ),
        ),
      ],
    );
  }
}

class _ExpBar extends StatelessWidget {
  final double height;
  final double percentage;

  const _ExpBar({
    Key? key,
    required this.percentage,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FAProgressBar(
      size: height,
      currentValue: percentage * 100,
      maxValue: 100,
      backgroundColor: kExpBarDefaultColor,
      progressColor: kExpBarFillColor,
      animatedDuration: const Duration(milliseconds: 500),
      borderRadius: BorderRadius.circular(height / 2),
    );
  }
}
