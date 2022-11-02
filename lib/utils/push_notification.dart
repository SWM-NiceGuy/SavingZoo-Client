import 'dart:convert';
import 'dart:io';

import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/utils/auth/auth_info.dart';
import 'package:amond/presentation/widget/dialogs/push_notification_permission_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

const String pushNotificationPermissionKey = 'pushNotificationPermission';
const String newUserKey = 'isNewUser-1.2.2';

Future<void> showPushNotificationPermissionDialog(BuildContext context) async {
  var prefs = await SharedPreferences.getInstance();
  var isNewUser = prefs.getBool(newUserKey);
  String? deviceToken;

  if (isNewUser != null) return;

  deviceToken = await FirebaseMessaging.instance.getToken();
  if (deviceToken == null) return;
  await _sendDeviceToken(deviceToken);

  prefs.setBool(newUserKey, false);


  await showDialog(
      context: context,
      builder: (context) => const PushNotificationPermissionDialog());

  var permissionSettings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // 푸시 알림을 거부했을 때 (iOS)
  if (permissionSettings.authorizationStatus == AuthorizationStatus.denied) {
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setBool(pushNotificationPermissionKey, false));
    _sendPushNotification(false);

    return;
  }

  // 푸시 알림을 허용했을 때
  SharedPreferences.getInstance()
      .then((prefs) => prefs.setBool(pushNotificationPermissionKey, true));
  _sendPushNotification(true);

  return;
}

Future<void> _sendDeviceToken(String token) async {
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

Future<void> _sendPushNotification(bool enable) async {
  final url = Uri.parse('$baseUrl/user/device/push');
  await http.post(
    url,
    body: jsonEncode({"allowPush": enable}),
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $globalToken',
    },
  );
}

Future<bool> getPushNotificationPermission() async {
  var prefs = await SharedPreferences.getInstance();
  var pushNotificationPermission = prefs.getBool(pushNotificationPermissionKey);
  if (pushNotificationPermission == null) return false;
  return pushNotificationPermission;
}

Future<void> setPushNotificationPermission(bool value) async {
  var prefs = await SharedPreferences.getInstance();
  prefs.setBool(pushNotificationPermissionKey, value);
  if (value == true) {
    var deviceToken = await FirebaseMessaging.instance.getToken();
    if (deviceToken == null) return;
    _sendDeviceToken(deviceToken);
  }
  _sendPushNotification(value);
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

Future<void> setUpForegroundNotification() async {
  // iOS 설정
  if (Platform.isIOS) {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    return;
  }

  // Android 설정
  if (Platform.isAndroid) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

    const android =
        AndroidInitializationSettings('@drawable/notification_icon');

    const initialSetting = InitializationSettings(android: android);
    flutterLocalNotificationsPlugin.initialize(initialSetting);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      String? title, body;

      title = notification?.title;
      body = notification?.body;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            0,
            title,
            body,
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

        // 미션 완료 처리

      }
    });
  }
}
