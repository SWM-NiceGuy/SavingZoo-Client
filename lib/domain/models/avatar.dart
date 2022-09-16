enum Avatar {
  baby(1, 'assets/images/first_apple_avatar.png', 0, '아기 아오리'),
  juvenile(2, 'assets/images/second_apple_avatar.png', 20, '꽃이 핀 아오리'),
  adult(3, 'assets/images/third_apple_avatar.png', 70, '서핑가는 아오리');

  const Avatar(this.level, this.imagePath, this.requiredExp, this.nickname);

  final int level;
  final String imagePath;
  final int requiredExp;
  final String nickname;

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

// avatarList[level] = 해당 레벨의 아바타
List<Avatar> avatarList = [
  Avatar.baby,
  Avatar.baby,
  Avatar.juvenile,
  Avatar.adult,
];