import 'package:flutter/material.dart';

class KakaoLoginContainer extends StatelessWidget {
  const KakaoLoginContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      width: deviceSize.width*0.8,
      child: Image.asset('assets/images/kakao_login_large_wide.png'),
    );
  }
}