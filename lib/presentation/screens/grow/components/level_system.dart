import 'package:amond/presentation/screens/grow/components/exp_bar.dart';
import 'package:amond/ui/colors.dart';
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
              Text(
                'LV$level',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  color: blackColor,
                ),
              ),
              GestureDetector(
                onTap: () => showExpGuidePopup(context),
                child: Row(
                  children: [
                    Text(
                      '${currentExp}xp / ${maxExp}xp',
                      style: TextStyle(color: blackColor),
                    ),
                    SizedBox(width: 4.0),
                    Icon(
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
        SizedBox(height: 12.0),
        ExpBar(width: width, height: height, percentage: percentage),
      ],
    );
  }
}
