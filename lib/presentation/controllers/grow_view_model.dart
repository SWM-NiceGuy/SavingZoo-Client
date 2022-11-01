import 'dart:async';
import 'dart:convert';

import 'package:amond/data/entity/character_entity.dart';
import 'package:amond/domain/models/character.dart';
import 'package:amond/domain/repositories/character_repository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GrowViewModel with ChangeNotifier {
  final CharacterRepository _characterRepository;

  GrowViewModel(this._characterRepository);

  bool _mounted = true;

  late Character _character;
  Character get character => _character;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool isMissionClear = false;

  bool isNewUser = false;

  bool get hasName => character.nickname != null;

  final int fadeDuration = 1000; // Fade 애니메이션 지속시간
  bool avatarIsVisible = true; // 아바타 보임 유무

  bool isHeartVisible = false; // 하트 애니메이션 보임 유무
  bool levelUpEffect = false;

  bool playButtonEnabled = true;

  int? increasedExp;

  int remainedPlayTime = 0;
  bool get canPlay => remainedPlayTime <= 0;

  final int _heartVisibleTime = 6;

  final heartComment = '사랑을 받으니 무엇이든\n할 수 있을 것만 같아요!';

  final _comments = [
    '미션을 수행해 주시면\n제가 성장할 수 있어요',
    '저도 커서 멋진\n어른이 될 수 있을까요?',
    '환경을 생각하는 마음이\n아름다워요!',
  ];
  int _commentOrder = 0;
  String get comment =>
      isHeartVisible ? heartComment : _comments[_commentOrder];

  /// 캐릭터의 경험치를 증가시키고 UI효과 발생
  Future<void> increaseExp(int value) async {
    increasedExp = null;

    // 레벨업 하지 않는 경우
    if (character.currentExp + value < character.maxExp) {
      character.currentExp += value;
      notifyListeners();
      return;
    }

    // 레벨업 하는 경우
    character.currentExp = character.maxExp;
    notifyListeners();

    // 캐릭터 fade 애니메이션
    avatarIsVisible = false;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: fadeDuration));

    await fetchData();
    
    avatarIsVisible = true;
    levelUpEffect = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1000));
    levelUpEffect = false;
    notifyListeners();
  }

  void changeComment() {
    FirebaseAnalytics.instance.logEvent(name: '캐릭터_코멘트_변경');
    _commentOrder = (_commentOrder + 1) % _comments.length;
    notifyListeners();
  }

  /// 캐릭터 데이터를 불러오는 함수
  /// 
  /// [_character]에 저장
  /// 
  /// [character]로 접근 가능
  Future<void> fetchData({bool missionClear = true}) async {
    try {
      // 서버에서 가져온 캐릭터
      var characterFromServer = await _characterRepository.getCharacter();

      // test용 서버에서 가져온 캐릭터
      // var characterFromServer = Character(
      //     id: 1,
      //     imageUrl:
      //         'https://cdn.imweb.me/upload/S20211110a3d216dc49446/f7bfffacbb6de.png',
      //     name: "안녕",
      //     nickname: null,
      //     currentExp: 5,
      //     maxExp: 30,
      //     remainedTime: 5);

      // 놀아주기 남은 시간 설정
      remainedPlayTime = characterFromServer.remainedTime ?? 0;
      if (remainedPlayTime <= 0) {
        playButtonEnabled = true;
      } else {
        playButtonEnabled = false;
      }

      _character = characterFromServer;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  /// [fetchData]를 통해 캐릭터 정보를 먼저 가져오고 캐릭터 이름이 있는지 확인
  /// 
  /// 만약 있으면 [true]
  /// 없으면 [false]를 반환
  Future<bool> checkIfCharacterHasName() async {
    await fetchData();
    return hasName;
  }


  /// 캐릭터의 이름이 없을때만 캐릭터 이름을 설정
  /// 
  /// 캐릭터 이름이 없으면 [name] 반환
  /// 
  /// 있으면 [null] 반환
  Future<String?> setNameIfNoName(String name) async {
    if (await checkIfCharacterHasName()) {
      await setCharacterName(name);
      return name;
    } else {
      return null;
    }
  }

  /// SharedPreferences 로컬 스토리지에 현재 캐릭터 상태를 저장
  Future<void> _saveCharacter(Character character) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'prevCharacter', jsonEncode(character.toEntity().toJson()));
  }

  /// 하트 버튼 누를 시 하트 효과
  void playWithCharacter() async {
    // 놀아주고 난 후 캐릭터 API 응답
    Character? resultCharacter =
        await _characterRepository.playWithCharacter(_character.id);

    // test용 서버에서 가져온 캐릭터
    // var resultCharacter = Character(
    //     id: 1,
    //     imageUrl:
    //         'https://cdn.imweb.me/upload/S20211110a3d216dc49446/f7bfffacbb6de.png',
    //     name: "안녕",
    //     nickname: null,
    //     currentExp: 5,
    //     maxExp: 30,
    //     remainedTime: 30);

    // 쿨타임이 남아 있으면 함수 끝
    if (resultCharacter == null) {
      return;
    }

    // 경험치가 올라간 캐릭터를 서버에 저장
    await fetchData(missionClear: false);

    if (isHeartVisible) {
      FirebaseAnalytics.instance
          .logEvent(name: '하트버튼_터치', parameters: {'type': '하트 보이는 중 누름'});
      return;
    }

    FirebaseAnalytics.instance
        .logEvent(name: '하트버튼_터치', parameters: {'type': '하트 안보이는 중 누름'});

    isHeartVisible = true;
    Future.delayed(Duration(seconds: _heartVisibleTime), () {
      isHeartVisible = false;
      if (_mounted) {
        notifyListeners();
      }
    });
  }

  Future<void> setCharacterName(String nickname) async {
    _character.nickname = nickname;
    notifyListeners();

    // 서버에 캐릭터 이름 저장
    _characterRepository.setName(character.id, nickname);
  }

  void togglePlayButton({required bool isActive}) {
    playButtonEnabled = isActive;
    if (isActive) {
      remainedPlayTime = 0;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }
}
