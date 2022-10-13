import 'dart:math';

import 'package:amond/ui/colors.dart' as amond_colors;
import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? darkShadowColor;
  final Color? lightShadowColor;
  final EdgeInsets? padding;
  final Widget? child;

  const ShadowContainer({
    required this.width,
    required this.height,
    this.backgroundColor,
    this.darkShadowColor,
    this.lightShadowColor,
    this.padding,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minSize = min(width, height);

    return Padding(
      padding: padding ?? EdgeInsets.all(minSize / 5),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? amond_colors.backgroundColor,
          borderRadius: BorderRadius.circular(minSize / 5),
          boxShadow: [
            BoxShadow(
              color: darkShadowColor ?? amond_colors.darkShadowColor,
              blurRadius: 1.0,
              offset: Offset(minSize / 100, minSize / 100),
            ),
            BoxShadow(
              color: lightShadowColor ?? amond_colors.lightShadowColor,
              blurRadius: 1.0,
              offset: Offset(-minSize / 100, -minSize / 100),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}


