import 'package:flutter/material.dart';

class MissionSubmitImageDetail extends StatelessWidget {
  const MissionSubmitImageDetail({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //       Navigator.of(context).pop();
        //     },
        //     child: Icon(Icons.close),
        //   )
        // ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: 'missionSubmitImageDetail',
          child: InteractiveViewer(
        minScale: 0.8,
        maxScale: 2.5,
            child: Image.network(
              imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}