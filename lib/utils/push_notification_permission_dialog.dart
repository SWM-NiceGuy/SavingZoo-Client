import 'package:amond/presentation/screens/grow/components/shadow_button.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class PushNotificationPermissionDialog extends StatelessWidget {
  const PushNotificationPermissionDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        width: deviceSize.width * 0.8,
        height: deviceSize.height * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: backgroundColor,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xffEEEFF5),
              Color.fromARGB(255, 211, 214, 222),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '알림을 허용해주세요',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              // 미션 완수 이미지
              LayoutBuilder(
                  builder: (_, constraints) => Image.asset(
                        'assets/images/bell.png',
                        width: constraints.maxWidth * 0.3,
                      )),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    '수행한 미션의 인증 결과를 받으실 수 있어요.',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '필요없는 알림은 띄우지 않을게요!',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) => ShadowButton(
                  width: constraints.maxWidth * 0.6,
                  height: 50,
                  borderRadius: 100,
                  onPress: () {
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Text(
                      '확인',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: expTextColor,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
