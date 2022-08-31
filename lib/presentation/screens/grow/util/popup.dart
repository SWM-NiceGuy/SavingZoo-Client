import 'dart:math';

import 'package:flutter/material.dart';
import 'package:word_break_text/word_break_text.dart';

import '../../../../ui/colors.dart';
import '../components/shadow_button.dart';

void showExpGuidePopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            width: 48.0,
            height: 3.0,
          ),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              '경험치',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          WordBreakText(
            '환경 보호 활동을 하면 경험치가 증가해요. 경험치가 전부 채워지면 아바타를 한 단계 진화시킬 수 있어요.',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: blackColor,
            ),
            wrapAlignment: WrapAlignment.center,
          ),
          SizedBox(height: 16.0),
          WordBreakText(
            '아바타가 최종 단계로 진화하면 실제 과일을 드려요!',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: blackColor,
            ),
            wrapAlignment: WrapAlignment.center,
          ),
          SizedBox(height: 16.0),
          Image.asset('assets/images/exp_guide_image.png'),
        ],
      ),
    ),
  );
}

void showMissionCompletePopup(
  BuildContext context,
  double screenWidth,
  double screenHeight,
  String title,
  int exp,
  String content,
  VoidCallback onDismiss,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      final minSize = min(screenWidth, screenHeight);
      return Center(
        child: Container(
          width: minSize * 5 / 6,
          height: minSize * 5 / 6,
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
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      '+ $exp XP',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                        color: expBarColor1,
                      ),
                    ),
                  ],
                ),
                WordBreakText(
                  content,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                  wrapAlignment: WrapAlignment.center,
                ),
                ShadowButton(
                  width: minSize / 2,
                  height: minSize / 8,
                  borderRadius: minSize / 8,
                  onPress: () {
                    Navigator.of(context).pop();
                    onDismiss();
                  },
                  child: Center(
                    child: Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: expBarColor1,
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
