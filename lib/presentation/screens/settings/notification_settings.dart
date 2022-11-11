import 'package:amond/presentation/controllers/settings_view_model.dart';
import 'package:amond/presentation/screens/settings/components/settings_alert_container.dart';
import 'package:amond/presentation/widget/platform_based_indicator.dart';
import 'package:amond/ui/colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsViewModel>().fetchNotificationData();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('알림 설정'),
      ),
      body: controller.isNotificationLoading
          ? const Center(
              child: PlatformBasedLoadingIndicator(),
            )
          : Column(
              children: [
                // 기기 푸시알림이 켜져 있지 않으면 컨테이너를 보여준다.
                if (!controller.isDevicePushNotificationGranted)
                  const SettingsAlertContainer(
                      content: '푸시 알림을 받으려면 기기에서 알림을 허용해주세요'),
                // 미션 푸시 알림 설정
                SwitchListTile.adaptive(
                  activeColor: blueColor100,
                  title: const Text(
                    '미션 알림',
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: const Text(
                    '미션 수행 결과',
                    style: TextStyle(
                        color: darkGreyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                  value: controller.isPushNotificationGranted,
                  onChanged: controller.isDevicePushNotificationGranted
                      ? (bool value) {
                          // FA 로그
                          FirebaseAnalytics.instance.logEvent(
                              name: '푸시알림_설정',
                              parameters: {'결과': value ? '켬' : '끔'});

                          controller.togglePushNotification(value);
                        }
                      : null,
                )
              ],
            ),
    );
  }
}
