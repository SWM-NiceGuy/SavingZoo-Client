import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MissionDetailBottomBar extends StatelessWidget {
  const MissionDetailBottomBar({
    Key? key,
    required this.reward,
  }) : super(key: key);

  final int reward;

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        height: kBottomNavigationBarHeight + 24,
        child: Row(
          children: [
            // 미션 state에 따라 버튼이 달라져야 함
            ElevatedButton(
              // 미션 인증버튼
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                XFile? image = await picker.pickImage(source: ImageSource.camera);

                if (image == null) return;
                
                // 미션 업로드 로직
                
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(
                    deviceSize.width * 0.65, kBottomNavigationBarHeight - 10)),
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.transparent;
                  }
                }),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color.fromARGB(255, 103, 160, 47);
                  } else if (states.contains(MaterialState.disabled)) {
                    return Colors.grey;
                  }
                  return const Color(0xff96CE5F);
                }),
              ),
              child: const Text('인증하기', style: TextStyle(fontSize: 24)),
            ),
            SizedBox(width: deviceSize.width * 0.05 - 5),
            // 얻는 보상
            Text(
              "+${reward}XP",
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
