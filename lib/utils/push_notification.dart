import 'dart:convert';
import 'dart:io';

import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/presentation/controllers/grow_controller.dart';
import 'package:amond/presentation/controllers/mission_controller.dart';
import 'package:amond/utils/auth/auth_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

Future<void> showPushNotificationPermissionDialog(BuildContext context) async {
  var prefs = await SharedPreferences.getInstance();
  var isNewUser = prefs.getBool('isNewUser');
  String? deviceToken;

  if (isNewUser != null) return;

  showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
            title: const Text("미션 수행 알림"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("미션 수행을 원활하게 하실 수 있도록 푸시 알림이 제공됩니다."),
                SizedBox(height: 12),
                Text('* 좌측 상단 메뉴의 설정창에서 푸시 알림 설정을 변경하실 수 있습니다',
                    style: TextStyle(fontSize: 12)),
              ],
            ),
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

    // 푸시 알림을 거부했을 때 (iOS)
    if (permissionSettings.authorizationStatus == AuthorizationStatus.denied) {
      SharedPreferences.getInstance()
          .then((prefs) => prefs.setBool('pushNotificationPermission', false));
      return;
    }

    // 푸시 알림을 허용했을 때
    deviceToken = await FirebaseMessaging.instance.getToken();
    if (deviceToken == null) return;
    await sendDeviceToken(deviceToken!);
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setBool('pushNotificationPermission', true));
    return;
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

Future<void> setUpForegroundNotification(BuildContext context) async {
  if (Platform.isAndroid) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  const android = AndroidInitializationSettings('@drawable/notification_icon');
  const ios = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const initialSetting = InitializationSettings(android: android, iOS: ios);
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

    try {
      context.read<GrowController>().fetchData();
      context.read<MissionController>().fetchMissions();
    } catch (e) {
      return;
    }
  });
}
