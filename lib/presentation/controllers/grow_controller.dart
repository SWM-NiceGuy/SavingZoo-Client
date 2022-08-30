import 'dart:async';

import 'package:flutter/material.dart';

enum Avatar {
  baby(1, 'assets/images/baby_apple.png', 20),
  juvenile(2, 'assets/images/many_leaves.png', 50),
  adult(3, 'assets/images/fully_grown.png', 50);

  const Avatar(this.level, this.imagePath, this.maxExp);

  final int level;
  final String imagePath;
  final int maxExp;

  Avatar getNext() {
    if (name == Avatar.baby.name) {
      return Avatar.juvenile;
    } else if (name == Avatar.juvenile.name) {
      return Avatar.adult;
    } else {
      return Avatar.baby;
    }
  }
}

class GrowController with ChangeNotifier {
  Avatar _avatar = Avatar.baby;

  int get level => _avatar.level;
  int currentExp = 0; // 현재 경험치
  int get maxExp => _avatar.maxExp; // 최대 경험치
  double expPercentage = 0.0; // 경험치 게이지 채워짐 정도 (0.0 ~ 1.0)

  String get avatarPath => _avatar.imagePath; // 아바타 이미지 경로
  int fadeDuration = 2000; // Fade 애니메이션 지속시간
  bool avatarIsVisible = true; // 아바타 보임 유무

  void _increaseExpBar(double from, double to) {
    int durationSeconds = 1; // 경험치 변화 애니메이션 시간
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
          changeAvatar();
        }
      },
    );
  }

  /// 경험치를 증가시킨다
  void increaseExp(int point) {
    if (_avatar == Avatar.adult) {
      return;
    }

    currentExp += point;

    if (currentExp > maxExp) {
      currentExp = maxExp;
    }

    notifyListeners();
    _increaseExpBar(expPercentage, currentExp / maxExp);
  }

  /// 경험치와 게이지를 초기화한다
  void resetExp() {
    currentExp = 0;
    expPercentage = 0.0;
    notifyListeners();
  }

  /// 다음 단계로 아바타를 변화시킨다.
  /// 2초간 사라진 후 0.5초 동안 다음 아바타를 등장시킨다
  void changeAvatar() {
    fadeDuration = 2000;
    avatarIsVisible = false;
    notifyListeners();

    Future.delayed(Duration(milliseconds: fadeDuration), () {
      _avatar = _avatar.getNext();
      fadeDuration = 500;
      avatarIsVisible = true;
      notifyListeners();

      if (_avatar == Avatar.adult) return;

      resetExp();
    });
  }
}
