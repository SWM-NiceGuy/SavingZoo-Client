import 'dart:io';

import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/controllers/settings_controller.dart';
import 'package:amond/presentation/screens/auth/auth_screen.dart';
import 'package:amond/presentation/screens/settings/components/settings_alert_container.dart';
import 'package:amond/ui/colors.dart';
import 'package:amond/utils/auth/do_auth.dart';
import 'package:amond/utils/show_platform_based_dialog.dart';
import 'package:amond/widget/platform_based_indicator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsController(),
      child: const SettingsScreenWidget(),
    );
  }
}

class SettingsScreenWidget extends StatefulWidget {
  const SettingsScreenWidget({Key? key}) : super(key: key);

  @override
  State<SettingsScreenWidget> createState() => _SettingsScreenWidgetState();
}

class _SettingsScreenWidgetState extends State<SettingsScreenWidget> {
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
          : SafeArea(
              child: Column(
                children: [
                  // 기기 푸시알림이 켜져 있지 않으면 컨테이너를 보여준다.
                  if (!controller.isDevicePushNotificationGranted)
                    const SettingsAlertContainer(
                        content: '푸시 알림을 받으려면 기기에서 알림을 허용해주세요'),
                  // 미션 푸시 알림 설정
                  SwitchListTile(
                    activeColor: const Color(0xffA3C908),
                    title: const Text('알림 ON / OFF'),
                    subtitle: const Text(
                      '미션 수행 결과에 대한 알림을 받을 수 있어요',
                      style: TextStyle(color: Colors.grey),
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
                    secondary: const Icon(
                      Icons.notifications,
                      color: Color(0xff343434),
                    ),
                  ),
                  const Spacer(),
                  // 로그 아웃
                  ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Color(0xff343434),
                      ),
                      title: const Text('로그아웃'),
                      onTap: () async {
                        _checkDialog(context, '로그아웃을 진행합니다').then(
                          (isAccepted) {
                            if (!isAccepted) return;
                            try {
                              context.read<AuthController>().logout().then((_) {
                                Navigator.of(context).popUntil(
                                  ModalRoute.withName('/'),
                                );
                                Navigator.of(context)
                                    .pushReplacementNamed(AuthScreen.routeName);
                              });
                            } catch (error) {
                              showPlatformBasedDialog(
                                  context, '로그아웃에 실패했습니다', '다시 시도해주세요.');
                            }
                          },
                        );
                      }),
                  // 계정 탈퇴
                  ListTile(
                    leading: const Icon(
                      Icons.delete_forever,
                      color: Color(0xff343434),
                    ),
                    title: const Text('AMOND 계정 탈퇴'),
                    onTap: () async {
                      FirebaseAnalytics.instance.logEvent(name: '회원탈퇴_터치');

                      _checkDialog(context, 'AMOND 계정 탈퇴',
                              'AMOND 계정을 탈퇴하면 저장된 데이터들을 복구할 수 없습니다, 진행하시겠습니까?')
                          .then((isAccepted) {
                        if (!isAccepted) return;

                        FirebaseAnalytics.instance.logEvent(name: '회원탈퇴');
                        try {
                          context
                              .read<DoAuth>()
                              .resign()
                              .then((resignResponse) {
                            context.read<AuthController>().resign(resignResponse).then((_) {
                              Navigator.of(context)
                                  .popUntil(ModalRoute.withName('/'));
                              Navigator.of(context)
                                  .pushReplacementNamed(AuthScreen.routeName);
                            });
                          });
                        } catch (error) {
                          showPlatformBasedDialog(
                              context, '회원탈퇴에 실패했습니다.', '다시 시도해주세요.');
                        }
                      });
                    },
                  )
                ],
              ),
            ),
    );
  }

  Future<bool> _checkDialog(BuildContext context, String title,
      [String? content]) async {
    bool response = false;
    if (Platform.isIOS) {
      response = await showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content ?? ''),
            actions: [
              CupertinoDialogAction(
                child: const Text('네'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              CupertinoDialogAction(
                child: const Text('아니오'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          );
        },
      );
    } else {
      response = await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: Text(content ?? ''),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('네'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('아니오'),
              ),
            ],
          );
        },
      );
    }
    return response;
  }
}
