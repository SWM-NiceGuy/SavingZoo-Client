import 'dart:convert';

import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/utils/auth/auth_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> showPushNotificationPermissionDialog(BuildContext context) async {
  var prefs = await SharedPreferences.getInstance();
  var isNewUser = prefs.getBool('isNewUser');
  String? deviceToken;

  if (isNewUser != null) return;

  showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
            title: const Text("푸시 알림 설정"),
            content: const Text("미션 수행 인증에 대한 푸시알림을 받아보세요!"),
            actions: <Widget>[
              BasicDialogAction(
                title: const Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )).then((_) async {
    NotificationSettings permissionSettings;
    permissionSettings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // 푸시 알림을 허용했을 때
    if (permissionSettings.authorizationStatus == AuthorizationStatus.denied) {
      return false;
    }
    deviceToken = await FirebaseMessaging.instance.getToken();
    if (deviceToken == null) return false;
    await sendDeviceToken(deviceToken!);
    return true;
  }).then((isAccepted) {
    if (isAccepted) {
      SharedPreferences.getInstance()
          .then((prefs) => prefs.setBool('pushNotificationPermission', true));
    }
    showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        content: const Text("'설정'에서 푸시알림 설정을 언제든 바꿀 수 있습니다."),
        actions: [
          BasicDialogAction(
            title: const Text('확인'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  });

  prefs.setBool('isNewUser', false);
}

Future<void> sendDeviceToken(String token) async {
  if (kDebugMode) {
    print('FM 토큰: $token');
  }
  final url = Uri.parse('$baseUrl/user/device/token');
  await http.post(
    url,
    body: jsonEncode({"deviceToken": token}),
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $globalToken',
    },
  );
}

Future<bool> getPushNotificationPermission() async {
  var prefs = await SharedPreferences.getInstance();
  var pushNotificationPermission = prefs.getBool('pushNotificationPermission');
  if (pushNotificationPermission == null) return false;
  return pushNotificationPermission;
}

Future<void> setPushNotificationPermission(bool value) async {
  var prefs = await SharedPreferences.getInstance();
  prefs.setBool('pushNotificationPermission', value);
  if (value == true) {
    var deviceToken = await FirebaseMessaging.instance.getToken();
    if (deviceToken == null) return;
    sendDeviceToken(deviceToken);
  } else {
    FirebaseMessaging.instance.deleteToken();
  }
}

// Android용 새 Notification Channel
const AndroidNotificationChannel androidNotificationChannel =
    AndroidNotificationChannel(
  'high_importance_channel', // 임의의 id
  'High Importance Notifications', // 설정에 보일 채널명
  description:
      'This channel is used for important notifications.', // 설정에 보일 채널 설명
  importance: Importance.max,
);

// Notification Channel을 디바이스에 생성
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> setUpAndroidForegroundNotification() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidNotificationChannel);

  const android = AndroidInitializationSettings('@drawable/notification_icon');
  const initialSetting = InitializationSettings(android: android);
  flutterLocalNotificationsPlugin.initialize(initialSetting);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          0,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                'high_importance_channel', 'High Importance Notifications',
                channelDescription:
                    'This channel is used for important notifications.',
                icon: android.smallIcon,
                importance: Importance.high,
                priority: Priority.high
                // other properties...
                ),
          ));
    }
  });
}
