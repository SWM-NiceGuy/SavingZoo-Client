import 'package:amond/presentation/widget/main_button.dart';
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
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(26.0))),
      child: SizedBox(
        width: deviceSize.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 상단 텍스트
                const Text(
                  '알림을 허용해주세요',
                  style: TextStyle(fontSize: 20, color: textBlueColor200),
                ),
                const SizedBox(height: 34),

                // 중앙 이미지
                     Image.asset(
                        'assets/images/push_noti_image.png',
                        width: 150,
                        height: 150,
                      ),

                const SizedBox(height: 44),

                // 하단 텍스트
                const Text(
                  '수행한 미션의 인증 결과를 받으실 수 있어요.\n필요없는 알림은 띄우지 않을게요!',
                  style: TextStyle(color: darkGreyColor, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                

                const SizedBox(height: 29),

                // 확인 버튼
                MainButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    width: 149,
                    height: 56,
                    child: const Text('확인'))
              ]),
        ),
      ),
    );
  }
}
