import 'dart:math';

import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class ShadowButton extends StatefulWidget {
  final VoidCallback onPress;
  final double width;
  final double height;
  final Widget? child;

  const ShadowButton({
    Key? key,
    required this.width,
    required this.height,
    required this.onPress,
    this.child,
  }) : super(key: key);

  @override
  State<ShadowButton> createState() => _ShadowButtonState();
}

class _ShadowButtonState extends State<ShadowButton> {
  Color bgColor = backgroundColor;

  @override
  Widget build(BuildContext context) {
    final minSize = min(widget.width, widget.height);

    return Padding(
      padding: EdgeInsets.all(minSize / 10),
      child: GestureDetector(
        onTapUp: (details) {
          widget.onPress();
          setState(() => bgColor = backgroundColor);
        },
        onTapCancel: () {
          setState(() => bgColor = backgroundColor);
        },
        onTapDown: (details) {
          setState(() => bgColor = darkShadowColor.withOpacity(0.7));
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius:
                BorderRadius.circular(min(widget.width, widget.height) / 5),
            boxShadow: [
              BoxShadow(
                color: darkShadowColor,
                blurRadius: 8.0,
                offset: Offset(minSize / 10, minSize / 10),
              ),
              BoxShadow(
                color: lightShadowColor,
                blurRadius: 8.0,
                offset: Offset(-minSize / 10, -minSize / 10),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
