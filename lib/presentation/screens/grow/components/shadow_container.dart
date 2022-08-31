import 'dart:math';

import 'package:amond/ui/colors.dart' as amond_colors;
import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? darkShadowColor;
  final Color? lightShadowColor;
  final Widget? child;

  const ShadowContainer({
    required this.width,
    required this.height,
    this.backgroundColor,
    this.darkShadowColor,
    this.lightShadowColor,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minSize = min(width, height);

    return Padding(
      padding: EdgeInsets.all(minSize / 5),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? amond_colors.backgroundColor,
          borderRadius: BorderRadius.circular(minSize / 5),
          boxShadow: [
            BoxShadow(
              color: darkShadowColor ?? amond_colors.darkShadowColor,
              blurRadius: 8.0,
              offset: Offset(minSize / 10, minSize / 10),
            ),
            BoxShadow(
              color: lightShadowColor ?? amond_colors.lightShadowColor,
              blurRadius: 8.0,
              offset: Offset(-minSize / 10, -minSize / 10),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}