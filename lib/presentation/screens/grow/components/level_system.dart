import 'package:amond/presentation/screens/grow/components/exp_bar.dart';
import 'package:flutter/material.dart';

import '../util/popup.dart';

class LevelSystem extends StatelessWidget {
  final double width;
  final double height;
  final int level;
  final int currentExp;
  final int maxExp;
  final double percentage;

  const LevelSystem({
    required this.width,
    required this.height,
    required this.level,
    required this.currentExp,
    required this.maxExp,
    required this.percentage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'LV$level',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontSize: 22.0, letterSpacing: 3.0),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => showExpGuidePopup(context),
                child: Row(
                  children: [
                    Text('${currentExp}xp / ${maxExp}xp'),
                    const SizedBox(width: 4.0),
                    const Icon(
                      Icons.info_outline,
                      color: Color(0xff919191),
                      size: 18.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        ExpBar(width: width, height: height, percentage: percentage),
      ],
    );
  }
}
