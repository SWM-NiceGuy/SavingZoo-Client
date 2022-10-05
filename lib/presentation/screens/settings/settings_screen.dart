import 'package:amond/presentation/controllers/settings_controller.dart';
import 'package:amond/ui/colors.dart';
import 'package:amond/utils/push_notification.dart';
import 'package:amond/widget/platform_based_indicator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsController>();

    if (controller.isLoading) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchData();
    });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        elevation: 0,
        foregroundColor: blackColor,
        shape: const Border(bottom: BorderSide(color: Color(0xffd7d7d7))),
      ),
      body: controller.isLoading
          ? const Center(child: PlatformBasedIndicator())
          : ListView(
              children: [
                // 미션 푸시 알림 설정
                SwitchListTile(
                  title: const Text('미션 수행 푸시 알림'),
                  subtitle: const Text(
                    '기기 설정에서 앱 알림 설정을 먼저 확인해주세요!',
                    style: TextStyle(color: Colors.grey),
                  ),
                  value: controller.isPushNotificationOn,
                  onChanged: (bool value) {
                    // FA 로그
                    FirebaseAnalytics.instance.logEvent(
                        name: '푸시알림_설정', parameters: {'결과': value ? '켬' : '끔'});

                    controller.togglePushNotification(value);
                  },
                  secondary: const Icon(Icons.notifications),
                )
              ],
            ),
    );
  }
}
