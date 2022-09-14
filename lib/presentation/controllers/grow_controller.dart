import 'dart:async';

import 'package:amond/domain/models/character.dart';
import 'package:amond/domain/usecases/exp/exp_use_cases.dart';
import 'package:flutter/material.dart';

import '../../domain/models/avatar.dart';
import '../../domain/models/member_info.dart';



class GrowController with ChangeNotifier {
  final ExpUseCases _expUseCases;
  final MemberInfo _memberInfo;
  GrowController(this._expUseCases, this._memberInfo);

  late Character _character;

  Character get character => _character;

  int missionCompleted = 0;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isDataFetched = false;
  bool get isDataFetched => _isDataFetched;

  bool isNewUser = false;

  bool hasBadge = false; // 개척자 배지 보유 여부
  int fadeDuration = 2000; // Fade 애니메이션 지속시간
  bool avatarIsVisible = true; // 아바타 보임 유무

  bool heartsIsVisible = false; // 하트 애니메이션 보임 유무
  final heartComment = '사랑을 받으니 무엇이든\n할 수 있을 것만 같아요!';

  final _comments = [
    '미션을 수행해 주시면\n제가 성장할 수 있어요',
    '저도 커서 멋진\n어른이 될 수 있을까요?',
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

        _character.expPercentage = from + (to - from) * count / 100;
        notifyListeners();

        if (count == 100) {
          timer.cancel();
          _character.expPercentage = to;
          notifyListeners();
        }

        if (_character.expPercentage == 1.0) {
          changeAvatar();
        }
      },
    );
  }

  /// 경험치를 증가시킨다
  Future<void> increaseExp(int point) async {
    _character.increaseExp(point, _increaseExpBar);

    notifyListeners();
    await changeExpInServer(_character.currentExp);
  }

  /// 다음 단계로 아바타를 변화시킨다.
  /// 2초간 사라진 후 0.5초 동안 다음 아바타를 등장시킨다
  void changeAvatar() {
    fadeDuration = 2000;
    avatarIsVisible = false;
    notifyListeners();

    Future.delayed(Duration(milliseconds: fadeDuration), () {
      _character.avatar = avatarList[_character.level + 1];
      fadeDuration = 500;
      avatarIsVisible = true;
      notifyListeners();

      if (_character.avatar == avatarList.last) {
        return;
      }

      _character.resetExp();
      notifyListeners();

      if (_character.extraExp > 0) {
        increaseExp(_character.extraExp);
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
    Future.delayed(const Duration(seconds: 6), () {
      heartsIsVisible = false;
      notifyListeners();
    });
  }

  /// 캐릭터 데이터를 불러오는 함수
  Future<void> fetchData(MemberInfo memberInfo) async {
    // 데이터 불러오기
    var currentExp = await _expUseCases.getExp(memberInfo.provider, memberInfo.uid);
    // 현재 경험치가 0이면 새로운 유저로 판단
    if (currentExp == 0) {
      isNewUser = true;
    }

    _character = Character.ofExp(currentExp);

    missionCompleted = await getMissionCompleted();

    _isDataFetched = true;
    _isLoading = false;

    notifyListeners();
  }

  /// 서버에서 [memberInfo]의 캐릭터의 경험치를 [value]로 바꿈
  Future<void> changeExpInServer(int value) async {
    await _expUseCases.changeExp(_memberInfo.provider, _memberInfo.uid, value);
  }

  Future<void> changeMissionCompleted(int value) async {
    missionCompleted = value;
    notifyListeners();
    await _expUseCases.changeMissionCompleted(_memberInfo.provider, _memberInfo.uid, value);
  }

  Future<int> getMissionCompleted() async {
    return await _expUseCases.getMissionCompleted(_memberInfo.provider, _memberInfo.uid);
  }
}
