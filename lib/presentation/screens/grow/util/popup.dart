import 'dart:math';

import 'package:amond/presentation/screens/grow/components/exp_bar.dart';
import 'package:flutter/material.dart';
import 'package:word_break_text/word_break_text.dart';

import '../../../../ui/colors.dart';
import '../components/shadow_button.dart';

void showExpGuidePopup(BuildContext context) {
  final normalStyle =
      Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16.0);

  final boldStyle = normalStyle?.copyWith(fontWeight: FontWeight.w700);

  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade300,
              width: 48.0,
              height: 3.0,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text('경험치',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 24.0)),
            ),
            WordBreakText(
              '환경 보호 활동을 하면 경험치가 증가해요. 경험치가 전부 채워지면',
              style: normalStyle,
              wrapAlignment: WrapAlignment.center,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: '아바타를 ', style: normalStyle),
                  TextSpan(text: '한 단계 진화', style: boldStyle),
                  TextSpan(text: '시킬 수 있어요.', style: normalStyle),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: '아바타가 LV3로 진화하면  ', style: normalStyle),
                  TextSpan(text: '실제 과일', style: boldStyle),
                  TextSpan(text: '을 드려요!', style: normalStyle),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/first_apple_avatar.png',
                      height: height * 0.15),
                  Image.asset('assets/images/right_arrow_icon.png'),
                  Image.asset('assets/images/anonymous_avatar.png',
                      height: height * 0.15),
                ],
              ),
            ),
            Text(
              '90xp / 100xp',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: expTextColor, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 6.0),
            ExpBar(width: width, height: 12.0, percentage: 0.9),
          ],
        ),
      ),
    ),
  );
}

void showPopup(
  {
  required BuildContext context,
  required String title,
  required Widget content,
  required VoidCallback onDismiss,
  }
) {
  final deviceSize = MediaQuery.of(context).size;
  final screenWidth = deviceSize.width;
  final screenHeight = deviceSize.height;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      final minSize = min(screenWidth, screenHeight);
      return Center(
        child: Container(
          width: minSize * 5 / 6,
          height: (minSize * 5 / 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: backgroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(minSize / 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                content,
                ShadowButton(
                  width: minSize / 2,
                  height: minSize / 8,
                  borderRadius: minSize / 8,
                  onPress: () {
                    Navigator.of(context).pop();
                    onDismiss();
                  },
                  child:  Center(
                    child: Text(
                      '확인',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: expTextColor,
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
