import 'package:amond/utils/push_notification.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;

class SettingsController with ChangeNotifier {
  var _isLoading = true;

  bool get isLoading => _isLoading;

  late bool isPushNotificationOn;

  void togglePushNotification(bool value) {
    setPushNotificationPermission(value);
    isPushNotificationOn = value;
    
    notifyListeners();
  }

  Future<void> fetchData() async {
    
    // 설정 데이터 불러오기
    isPushNotificationOn = await getPushNotificationPermission();
    
    _isLoading = false;
    notifyListeners();
  }
}