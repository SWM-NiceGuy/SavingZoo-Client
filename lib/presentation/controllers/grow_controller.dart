import 'dart:async';
import 'dart:convert';

import 'package:amond/data/entity/character_entity.dart';
import 'package:amond/domain/models/character.dart';
import 'package:amond/domain/usecases/character/character_use_cases.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GrowController with ChangeNotifier {
  final CharacterUseCases _characterUseCases;
  GrowController(this._characterUseCases);

  late Character _character;
  Character get character => _character;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isDataFetched = false;
  bool get isDataFetched => _isDataFetched;

  bool _isMissionClear = false;
  bool get isMissionClear => _isMissionClear;

  bool isNewUser = false;

  final int fadeDuration = 1000; // Fade 애니메이션 지속시간
  bool avatarIsVisible = true; // 아바타 보임 유무

  bool heartsIsVisible = false; // 하트 애니메이션 보임 유무
  bool levelUpEffect = false;

  int? increasedExp;

  final heartComment = '사랑을 받으니 무엇이든\n할 수 있을 것만 같아요!';

  final _comments = [
    '미션을 수행해 주시면\n제가 성장할 수 있어요',
    '저도 커서 멋진\n어른이 될 수 있을까요?',
    '환경을 생각하는 마음이\n아름다워요!',
  ];
  int _commentOrder = 0;
  String get comment =>
      heartsIsVisible ? heartComment : _comments[_commentOrder];

  /// 경험치를 증가시킨다
  Future<void> increaseExp(int value) async {
    // 레벨업 하지 않는 경우
    if (character.currentExp + value < character.maxExp) {
      character.currentExp += value;
      notifyListeners();
      _saveCharacter(character);
      return;
    }

    // 레벨업 하는 경우
    character.currentExp = character.maxExp;
    notifyListeners();

    // 캐릭터 fade 애니메이션
    avatarIsVisible = false;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: fadeDuration));

    // _character = 서버에서 가져온 캐릭터;
    _character = Character(
      id: 1,
      name: '안녕',
      nickname: '안녕하세요',
      currentExp: 10,
      maxExp: 50,
      level: 2,
      imageUrl: 'assets/images/second_apple_avatar.png',
    );
    avatarIsVisible = true;
    levelUpEffect = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1000));
    levelUpEffect = false;
    notifyListeners();
    _saveCharacter(character);
  }

  void changeComment() {
    _commentOrder = (_commentOrder + 1) % _comments.length;
    notifyListeners();
  }

  /// 하트 버튼 누를 시 하트 효과
  void showHearts() {
    if (heartsIsVisible) {
      return;
    }

    heartsIsVisible = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 6), () {
      heartsIsVisible = false;
      notifyListeners();
    });
  }

  void setCharacterName(String name) {
    _character.name = name;
    notifyListeners();

    // 서버에 캐릭터 이름 저장
    _characterUseCases.setName(name);
  }

  /// 캐릭터 데이터를 불러오는 함수
// {
// 	캐릭터 ID id
// 	캐릭터 이미지 image
// 	캐릭터 닉네임 nickname
// 	캐릭터 레벨 currentLevel
// 	캐릭터 현재경험치 currentExp
// 	캐릭터 최대경험치 maxExp
// }
  Future<void> fetchData() async {
    // var currentExp = await _characterUseCases.getExp();
    // // var currentExp = 30;
    // var name = await _characterUseCases.getName();
    // characterName = '장금이';
    // 캐릭터 닉네임이 없으면 새로운 유저로 판단
    // if (name == null) {
    //   isNewUser = true;
    // }

    // characterName = name;

    final prefs = await SharedPreferences.getInstance();

    var prevCharacterJson = prefs.getString('prevCharacter');
    // 저장되어 있던 캐릭터 정보가 없으면 서버에서 가져온 캐릭터로 로드
    if (prevCharacterJson == null) {
      // 서버에서 가져온 캐릭터
      _character = Character(
          id: 1,
          imageUrl: 'assets/images/first_apple_avatar.png',
          name: "안녕",
          nickname: "안녕하세요",
          maxExp: 30);
      _isDataFetched = true;
      _isLoading = false;

      notifyListeners();
      return;
    }
    Character prevCharacter = Character.fromEntity(
        CharacterEntity.fromJson(jsonDecode(prevCharacterJson)));

    // 서버에서 가져온 캐릭터
    var characterFromServer = Character(
        id: 1,
        imageUrl: 'assets/images/first_apple_avatar.png',
        name: "안녕",
        nickname: "안녕하세요",
        maxExp: 30);

    // 저장되어 있던 캐릭터 정보와 서버에서 불러온 캐릭터 정보가 같으면 서버 캐릭터로 로드
    if (prevCharacter.level == characterFromServer.level &&
        prevCharacter.currentExp == characterFromServer.currentExp) {
      _character = characterFromServer;
      _isDataFetched = true;
      _isLoading = false;
      return;
    }

    _isMissionClear = true;
    _isDataFetched = true;
    _isLoading = false;
    increasedExp = (prevCharacter.maxExp - prevCharacter.currentExp) +
        characterFromServer.currentExp;
    notifyListeners();
  }

  /// 서버에서 [memberInfo]의 캐릭터의 경험치를 [value]로 바꿈
  Future<void> changeExpInServer(int value) async {
    await _characterUseCases.changeExp(value);
  }

  Future<void> _saveCharacter(Character character) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('prevCharacter', jsonEncode(character.toEntity().toJson()));
  }
}
