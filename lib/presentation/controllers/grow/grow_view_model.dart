import 'dart:async';
import 'dart:convert';

import 'package:amond/domain/models/character.dart';
import 'package:amond/domain/repositories/character_repository.dart';
import 'package:amond/presentation/controllers/grow/grow_ui_event.dart';
import 'package:amond/presentation/screens/grow/components/level_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GrowViewModel with ChangeNotifier {
  final CharacterRepository _characterRepository;

  GrowViewModel(this._characterRepository);

  /// UI Event를 알려주는 스트림 컨트롤러
  final _uiEventController = StreamController<GrowUiEvent>.broadcast();
  Stream<GrowUiEvent> get eventStream => _uiEventController.stream;

  /// 인스턴스가 사라지면 이 값은 false
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

  /// 캐릭터의 경험치를 증가시킨다.
  Future<void> increaseExp() async {

    // 현재 캐릭터
    final currentCharacter = _character;
    // 경험치가 올라간 캐릭터
    final updatedCharacter = await _characterRepository.getCharacter();

    // 레벨업 하지 않는 경우
    if (currentCharacter.level == updatedCharacter.level) {
      await setCharacter();
      notifyListeners();
      return;
    }

    // 레벨업 하는 경우
    character.currentExp = character.maxExp;
    notifyListeners();
    // 경험치가 다 차고 레벨업 다이얼로그 UI Event발생
    await Future.delayed(const Duration(milliseconds: ExpBar.expAnimationDuration)).then((_) {
      _uiEventController.add(const GrowUiEvent.levelUp());
    });

    _character = updatedCharacter;
    // 캐릭터 fade 애니메이션
    avatarIsVisible = false;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: fadeDuration));
    
    avatarIsVisible = true;
    levelUpEffect = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1000));
    levelUpEffect = false;
    notifyListeners();
  }

  /// 캐릭터 데이터를 불러오고 Grow Screen 화면을 설정
  Future<void> fetchData() async {
    try {
      // 서버에서 가져온 캐릭터
      _isLoading = true;
      notifyListeners();
      await setCharacter();

      
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
      
      /// 놀아주기 남은 시간 설정
      /// view에서는 [_character.remainedTime]에 직접 접근하지 않음
      remainedPlayTime = _character.remainedTime ?? 0;
      if (remainedPlayTime <= 0) {
        playButtonEnabled = true;
      } else {
        playButtonEnabled = false;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }


  /// [notifyListeners] 호출 없이 캐릭터만 설정
  Future<void> setCharacter() async {
    _character = await _characterRepository.getCharacter();
  }

  /// [setCharacter]를 통해 캐릭터 정보를 먼저 가져오고 캐릭터 이름이 있는지 확인
  /// 
  /// 만약 있으면 [true]
  /// 없으면 [false]를 반환
  Future<bool> checkIfCharacterHasName() async {
    await setCharacter();
    return hasName;
  }


  /// 캐릭터의 이름이 없을때만 캐릭터 이름을 설정
  /// 
  /// 캐릭터 이름이 없으면 [name] 반환
  /// 
  /// 있으면 [null] 반환
  Future<String?> setNameIfNoName(String name) async {
    if (!await checkIfCharacterHasName()) {
      await setCharacterName(name);
      return name;
    } else {
      return null;
    }
  }

  /// 캐릭터 먹이주기
  Future<void> feed() async {
    await _characterRepository.feed();
    increaseExp();
  }

  /// 하트 버튼 누를 시 하트 효과
  Future<void> playWithCharacter() async {
    // 놀아주고 난 후 캐릭터 API 응답
    Character? resultCharacter =
        await _characterRepository.playWithCharacter(_character.id);

    // 쿨타임이 남아 있으면 함수 끝
    if (resultCharacter == null) {
      return;
    }

    remainedPlayTime = resultCharacter.remainedTime!;
    notifyListeners();
    // 캐릭터의 경험치를 올린다.
    await increaseExp();

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
    // 서버에 캐릭터 이름 저장
    await _characterRepository.setName(character.id, nickname);
  }

  /// view의 타이머 시간을 0으로 설정
  void clearPlayTime() {
    remainedPlayTime = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }
}
