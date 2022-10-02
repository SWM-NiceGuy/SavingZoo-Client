import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MissionPhoto extends StatefulWidget {
  MissionPhoto({Key? key, required this.photo}) : super(key: key);

  static const routeName = '/mission-photo';

  XFile photo;

  @override
  State<MissionPhoto> createState() => _MissionPhotoState();
}

class _MissionPhotoState extends State<MissionPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      bottomSheet: BottomAppBar(
        child: Container(
          width: double.infinity,
          height: kBottomNavigationBarHeight + 40,
          color: Colors.grey.shade800,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () async {
                  final _picker = ImagePicker();
                  XFile? photo =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (photo == null) return;
                  setState(() {
                    widget.photo = photo;
                  });
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.transparent;
                    }
                    return null;
                  }),
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color.fromARGB(64, 158, 158, 158);
                      }
                      return null;
                    },
                  ),
                ),
                child: const Text("다시 찍기",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.transparent;
                    }
                    return null;
                  }),
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color.fromARGB(64, 158, 158, 158);
                      }
                      return null;
                    },
                  ),
                ),
                child: const Text("사진 사용",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.file(File(widget.photo.path)),
      ),
    );
  }
}
