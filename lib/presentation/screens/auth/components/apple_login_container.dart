import 'package:flutter/material.dart';

class AppleLoginContainer extends StatelessWidget {
  const AppleLoginContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
        width: deviceSize.width * 0.8,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(85),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 24,
              child: Image.asset('assets/images/apple_icon.png',
                  width: 22, height: 22),
            ),
            const Text('Apple로 계속하기',
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ));
  }
}
