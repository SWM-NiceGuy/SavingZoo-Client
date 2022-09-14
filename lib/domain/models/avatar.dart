enum Avatar {
  baby(1, 'assets/images/first_apple_avatar.png', 0),
  juvenile(2, 'assets/images/second_apple_avatar.png', 20),
  adult(3, 'assets/images/third_apple_avatar.png', 70);

  const Avatar(this.level, this.imagePath, this.requiredExp);

  final int level;
  final String imagePath;
  final int requiredExp;

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