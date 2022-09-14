import 'avatar.dart';

class Character {
  Avatar avatar = Avatar.baby;

  Character.ofExp(int exp) {
    currentExp = exp;
    for (var elem in avatarList.reversed) {
      if (exp > elem.requiredExp) {
        avatar = elem;
        break;
      }
    }
    expPercentage = (currentExp - avatar.requiredExp) / maxExp;
  }

  int get level => avatar.level;
  int currentExp = 0; // 현재 경험치
  int get maxExp => avatar == avatarList.last
      ? 50
      : avatarList[level+1].requiredExp - avatar.requiredExp; // 최대 경험치
  int extraExp = 0; // 증가한 경험치가 최대 경험치를 넘었을 때의 잔여 경험치
  double expPercentage = 0.0; // 경험치 게이지 채워짐 정도 (0.0 ~ 1.0)
  String get avatarPath => avatar.imagePath;

  int get displayExp =>
      avatar == Avatar.adult ? 50 : currentExp - avatar.requiredExp;

  ///
  ///
  void increaseExp(int point, [Function? callback]) async {
    if (avatar == avatarList.last) {
      return;
    }

    // 경험치 증가 로직
    currentExp += point;

    if (currentExp > avatarList[level + 1].requiredExp) {
      extraExp = currentExp - avatarList[level].requiredExp;
      currentExp = avatarList[level + 1].requiredExp;
    }

    // 화면상에 보여주는 함수를 callback으로 호출
    if (callback != null) {
      callback(expPercentage,
        displayExp / (avatar.getNext().requiredExp - avatar.requiredExp));
    }
  }

  void resetExp() {
    currentExp = avatar.requiredExp;
    expPercentage = 0.0;
  }
}
