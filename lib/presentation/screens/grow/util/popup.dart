import 'dart:math';

import 'package:flutter/material.dart';
import 'package:word_break_text/word_break_text.dart';

import '../../../../ui/colors.dart';
import '../components/shadow_button.dart';

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
