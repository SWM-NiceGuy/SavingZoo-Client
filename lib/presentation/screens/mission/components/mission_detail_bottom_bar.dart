import 'package:flutter/material.dart';

class MissionDetailBottomBar extends StatelessWidget {
  const MissionDetailBottomBar({
    Key? key,
  }) : super(key: key);

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
            ElevatedButton(
              onPressed: () {},
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
                    return const Color.fromARGB(255, 71, 119, 182);
                  }
                  return const Color(0xff6BA9FF);
                }),
              ),
              child: const Text('인증하기', style: TextStyle(fontSize: 24)),
            ),
            SizedBox(width: deviceSize.width * 0.05 - 5),
            // 얻는 보상
            Text(
              "+8XP",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}