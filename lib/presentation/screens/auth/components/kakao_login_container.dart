import 'package:flutter/material.dart';

class KakaoLoginContainer extends StatelessWidget {
  const KakaoLoginContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
        width: deviceSize.width * 0.8,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xffFFEB3B),
          borderRadius: BorderRadius.circular(85),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 24,
              child: Image.asset('assets/images/kakao_icon.png',
                  width: 22, height: 22),
            ),
            const Positioned(
              child: Text('Kakao로 계속하기',
                  style: TextStyle(fontSize: 16, color: Color(0xff181602))),
            ),
          ],
        ));
  }
}
