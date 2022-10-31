import 'package:amond/utils/push_notification.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:permission_handler/permission_handler.dart';

class SettingsViewModel with ChangeNotifier {
  var _isLoading = true;

  bool get isLoading => _isLoading;

  late bool isPushNotificationGranted;
  late bool isDevicePushNotificationGranted;

  void togglePushNotification(bool value) {
    setPushNotificationPermission(value);
    isPushNotificationGranted = value;
    
    notifyListeners();
  }

  Future<void> fetchData() async {
    
    // 설정 데이터 불러오기
    isPushNotificationGranted = await getPushNotificationPermission();
    isDevicePushNotificationGranted = await Permission.notification.isGranted;
    
    _isLoading = false;
    notifyListeners();
  }
}