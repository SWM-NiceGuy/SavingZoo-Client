import 'package:flutter/material.dart';

class MissionExample extends StatelessWidget {
  const MissionExample({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: deviceSize.width * 0.4,
      child: AspectRatio(
        aspectRatio: 3.0 / 4.0,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}