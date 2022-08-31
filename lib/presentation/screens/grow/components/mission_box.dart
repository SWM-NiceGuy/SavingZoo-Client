import 'package:amond/presentation/screens/grow/components/shadow_container.dart';
import 'package:flutter/material.dart';

class MissionBox extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final String content;
  final String imagePath;
  final bool isComplete;

  const MissionBox({
    Key? key,
    required this.width,
    required this.height,
    required this.title,
    required this.content,
    required this.imagePath,
    this.isComplete = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      width: width,
      height: height,
      backgroundColor: isComplete ? Colors.grey.shade400 : null,
      child: Stack(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(height / 4),
                child: Image.asset(imagePath, height: height / 2),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 14.0)),
                  SizedBox(height: 6.0),
                  Text(content, style: TextStyle(fontSize: 16.0))
                ],
              )
            ],
          ),
          Center(
            child: isComplete
                ? const Text(
                    'COMPLETE',
                    style: TextStyle(
                        fontSize: 32.0,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
