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
  final Widget? leading;

  const LevelSystem({
    required this.width,
    required this.height,
    required this.level,
    required this.currentExp,
    required this.maxExp,
    required this.percentage,
    this.leading,
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
                  leading != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: leading,
                        )
                      : const SizedBox(),
                  Text(
                    'LV$level',
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => showExpGuidePopup(context),
                child: Row(
                  children: [
                    Text(
                      '${currentExp}xp / ${maxExp}xp',
                      style: const TextStyle(color: blackColor),
                    ),
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
