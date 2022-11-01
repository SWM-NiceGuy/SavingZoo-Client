import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainViewModel with ChangeNotifier {
  static const String notShowUpdateLogDuration = 'updateLog';

  /// '다시 보지 않기'를 누른 시간을 저장
  Future<void> doNotShowAgain() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(
        notShowUpdateLogDuration, DateTime.now().millisecondsSinceEpoch);
  }

  /// '다시 보지 않기'를 누른 시간과 인자로 전달한 [duration]과 비교해서
  /// 지났으면 [true]를 반환, 아니면 [false]를 반환
  Future<bool> checkDuration(

      /// 다시 보지 않기 key값
      String key,

      /// '다시 보지 않기' 기간
      Duration duration) async {
    var prefs = await SharedPreferences.getInstance();
    final startDate = prefs.getInt(key) ?? 0;
    var epochDuration = duration.inSeconds * 1000;

    return DateTime.now().millisecondsSinceEpoch >= startDate + epochDuration;
  }

  
}
