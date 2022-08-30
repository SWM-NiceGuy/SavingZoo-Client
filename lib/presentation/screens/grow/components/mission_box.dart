import 'package:amond/presentation/screens/grow/components/shadow_container.dart';
import 'package:flutter/material.dart';

class MissionBox extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final String content;
  final String imagePath;

  const MissionBox({
    Key? key,
    required this.width,
    required this.height,
    required this.title,
    required this.content,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      width: width,
      height: height,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(height / 4),
            child: Image.asset(imagePath, height: height / 2),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Mission 1', style: TextStyle(fontSize: 14.0)),
              SizedBox(height: 6.0),
              Text('공원 한바퀴', style: TextStyle(fontSize: 16.0))
            ],
          )
        ],
      ),
    );
  }
}
