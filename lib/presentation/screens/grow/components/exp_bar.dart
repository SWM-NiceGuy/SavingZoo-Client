import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import '../../../../ui/colors.dart';

class ExpBar extends StatelessWidget {
  final double width;
  final double height;
  final double percentage;

  const ExpBar({
    Key? key,
    required this.width,
    required this.height,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height),
        color: backgroundColor,
        border: Border.all(color: Colors.white, width: 0.15),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFC6CEDA),
            blurRadius: 3.0,
            offset: Offset(0, -1.5),
          ),
          BoxShadow(
            color: Color(0xFFFEFEFF),
            blurRadius: 3.0,
            offset: Offset(0, 1.5),
          ),
        ],
      ),
      child: FAProgressBar(
        currentValue: percentage * 100,
        maxValue: 100,
        // backgroundColor: Colors.grey.shade300,
        backgroundColor: Colors.transparent,
        progressColor: expBarColor1,
        animatedDuration: const Duration(milliseconds: 500),
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }
}
