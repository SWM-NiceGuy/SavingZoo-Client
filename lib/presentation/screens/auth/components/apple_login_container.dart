import 'package:flutter/material.dart';

class AppleLoginContainer extends StatelessWidget {
  const AppleLoginContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      width: deviceSize.width*0.8,
      child: Image.asset('assets/images/appleid_button.png'),
    );
  }
}