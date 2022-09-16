import 'package:amond/presentation/screens/grow/components/shadow_container.dart';
import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  final String comment;
  final double width;
  final double height;

  const CommentBox({
    Key? key,
    required this.comment,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      width: width,
      height: height,
      child: Center(
        child: Text(
          comment,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontSize: 16.0, height: 1.5),
        ),
      ),
    );
  }
}
