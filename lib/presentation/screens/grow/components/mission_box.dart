import 'package:amond/presentation/screens/grow/components/shadow_container.dart';
import 'package:flutter/material.dart';

class MissionBox extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final String content;
  final String imagePath;
  final bool isComplete;
  final EdgeInsets? padding;

  const MissionBox({
    Key? key,
    required this.width,
    required this.height,
    required this.title,
    required this.content,
    required this.imagePath,
    this.isComplete = false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      width: width,
      height: height,
      padding: padding,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: height / 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(imagePath, height: height / 2),
                SizedBox(width: height / 4),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 14.0)),
                    SizedBox(height: 6.0),
                    Text(content, style: TextStyle(fontSize: 16.0))
                  ],
                ),
              ],
            ),
            isComplete
                ? Image.asset('assets/images/check_icon.png')
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
