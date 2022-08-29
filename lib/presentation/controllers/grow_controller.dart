import 'dart:async';

import 'package:flutter/material.dart';

class GrowController with ChangeNotifier {
  int currentExp = 0; // 현재 경험치
  int maxExp = 20; // 최대 경험치
  double expPercentage = 0.0; // 경험치 막대 채워짐 정도 (0.0 ~ 1.0)

  void _increaseExpBar(double from, double to) {
    int durationSeconds = 1; // 게이지 변화 애니메이션 시간
    int count = 0;

    Timer.periodic(
      Duration(milliseconds: (durationSeconds * 1000) ~/ 100),
      (timer) {
        count++;

        expPercentage = from + (to - from) * count / 100;
        notifyListeners();

        if (count == 100) {
          timer.cancel();
          expPercentage = to;
          notifyListeners();
        }

        if (expPercentage == 1.0) {
          // changeAvatar();
        }
      },
    );
  }

  // 경험치를 증가시킨다
  void increaseExp(int point) {
    currentExp += point;

    if (currentExp > maxExp) {
      currentExp = maxExp;
    }

    notifyListeners();
    _increaseExpBar(expPercentage, currentExp / maxExp);
  }
}
