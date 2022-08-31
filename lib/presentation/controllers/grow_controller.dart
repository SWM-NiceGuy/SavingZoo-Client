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
  int _extraExp = 0; // 증가한 경험치가 최대 경험치를 넘었을 때의 잔여 경험치
  double expPercentage = 0.0; // 경험치 게이지 채워짐 정도 (0.0 ~ 1.0)

  String get avatarPath => _avatar.imagePath; // 아바타 이미지 경로
  int fadeDuration = 2000; // Fade 애니메이션 지속시간
  bool avatarIsVisible = true; // 아바타 보임 유무

  bool heartsIsVisible = false; // 하트 애니메이션 보임 유무
  final heartComment = '사랑을 받으니 무엇이든\n할 수 있을 것만 같아요!';

  final _comments = [
    '저를 키워주신\n첫번째 아몬더에요!',
    '주인님의 미션 수행으로\n제가 성장할수 있어요',
    '환경을 생각하는 마음이\n아름다워요!',
  ];
  int _commentOrder = 0;
  String get comment =>
      heartsIsVisible ? heartComment : _comments[_commentOrder];

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
      _extraExp = currentExp - maxExp;
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

      if (_extraExp > 0) {
        increaseExp(_extraExp);
      }
    });
  }

  void changeComment() {
    _commentOrder = (_commentOrder + 1) % _comments.length;
    notifyListeners();
  }

  void showHearts() {
    if (heartsIsVisible) {
      return;
    }

    heartsIsVisible = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 6), () {
      heartsIsVisible = false;
      notifyListeners();
    });
  }
}