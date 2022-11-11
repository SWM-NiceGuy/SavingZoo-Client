import 'dart:io';

import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/controllers/settings_view_model.dart';
import 'package:amond/presentation/screens/auth/auth_screen.dart';
import 'package:amond/presentation/screens/settings/notification_settings.dart';
import 'package:amond/presentation/screens/settings/support_settings.dart';
import 'package:amond/presentation/screens/settings/user_info_settings.dart';
import 'package:amond/presentation/widget/platform_based_indicator.dart';
import 'package:amond/ui/colors.dart';
import 'package:amond/ui/text_styles.dart';
import 'package:amond/presentation/widget/show_platform_based_dialog.dart';
import 'package:amond/utils/version/app_version.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsViewModel(),
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
    final controller = context.watch<SettingsViewModel>();

    if (controller.isNotificationLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchNotificationData();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        elevation: 0,
        foregroundColor: blackColor,
      ),
      body: controller.isNotificationLoading
          ? const Center(child: PlatformBasedLoadingIndicator())
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      '개인 설정',
                      style: TextStyle(color: blackColor, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    minLeadingWidth: 0,
                    horizontalTitleGap: 14,
                    leading: Image.asset('assets/images/person_icon.png',
                        width: 24, height: 24),
                    title: const Text('회원 정보 수정', style: settingsTextStyle),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const UserInfoSettings()));
                    },
                  ),
                  ListTile(
                    minLeadingWidth: 0,
                    horizontalTitleGap: 14,
                    leading: Image.asset('assets/images/alert_icon.png',
                        width: 24, height: 24),
                    title: const Text('알림 설정', style: settingsTextStyle),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const NotificationSettings()));
                    },
                  ),
                  ListTile(
                      minLeadingWidth: 0,
                      horizontalTitleGap: 14,
                      leading: Image.asset('assets/images/lock_icon.png',
                          width: 24, height: 24),
                      title: const Text('로그아웃', style: settingsTextStyle),
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
                  const Divider(
                    thickness: 0.2,
                    indent: 20,
                    endIndent: 20,
                    color: greyColor,
                  ),

                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      '서비스',
                      style: TextStyle(color: blackColor, fontSize: 18),
                    ),
                  ),
                  ListTile(
                    minLeadingWidth: 0,
                    horizontalTitleGap: 14,
                    leading: Image.asset('assets/images/person_call_icon.png',
                        width: 24, height: 24),
                    title: const Text('고객 센터', style: settingsTextStyle),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const SupportSettings()));
                    },
                  ),
                  ListTile(
                    minLeadingWidth: 0,
                    horizontalTitleGap: 14,
                    leading: Image.asset('assets/images/version_icon.png',
                        width: 24, height: 24),
                    title: const Text('버전 정보 $appVersion', style: settingsTextStyle),
                    onTap: () {
                     
                    },
                  ),
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
