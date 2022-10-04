import 'dart:io';

import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/screens/auth/auth_screen.dart';
import 'package:amond/presentation/screens/mission/mission_history_screen.dart';
import 'package:amond/presentation/screens/mission/mission_screen.dart';
import 'package:amond/presentation/screens/settings/settings_screen.dart';
import 'package:amond/utils/auth/do_auth.dart';
import 'package:amond/utils/push_notification.dart';
import 'package:amond/utils/show_platform_based_dialog.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:amond/presentation/screens/grow/grow_screen.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String routeName = '/main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> bottomNavigationBarScreens = [
    const GrowScreen(),
    MissionScreen(),
  ];

  List<Widget> appBarTitle = [
    const Text(""),
    const Text("미션"),
  ];

  var _screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 처음 접속하는 유저들에게 푸시 알림 설정을 받음.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!Navigator.of(context).canPop()) {
        showPushNotificationPermissionDialog(context);
      }
    });

    final authController = context.read<AuthController>();
    return Scaffold(
      drawer: mainDrawer(context, authController),
      appBar: AppBar(
        title: appBarTitle[_screenIndex],
        foregroundColor: Colors.black,
        elevation: 0.0,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: Color(0xFF96CE5F)),
      ),
      body: SafeArea(
        child: bottomNavigationBarScreens[_screenIndex],
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.white, offset: Offset(-5, -5), blurRadius: 9)
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            backgroundColor: backgroundColor,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                label: '홈',
                icon: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Color(0xffA6B4C8),
                        offset: Offset(3, 5),
                        blurRadius: 7)
                  ], shape: BoxShape.circle),
                  child: Image.asset('assets/images/home_normal.png',
                      width: 40, height: 40),
                ),
                activeIcon: Image.asset(
                  'assets/images/home_pressed.png',
                  width: 40,
                  height: 40,
                ),
              ),
              BottomNavigationBarItem(
                label: '미션',
                icon: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Color(0xffA6B4C8),
                        offset: Offset(3, 5),
                        blurRadius: 7)
                  ], shape: BoxShape.circle),
                  child: Image.asset('assets/images/mission_normal.png',
                      width: 40, height: 40),
                ),
                activeIcon: Image.asset(
                  'assets/images/mission_pressed.png',
                  width: 40,
                  height: 40,
                ),
              )
            ],
            onTap: (index) {
              setState(() {
                _screenIndex = index;
              });
            },
            currentIndex: _screenIndex,
          ),
        ),
      ),
    );
  }

  Drawer mainDrawer(BuildContext context, AuthController authController) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(
                Icons.history,
                color: blackColor,
              ),
              title: const Text('미션수행 기록'),
              onTap: () {
                // FA 로그
                FirebaseAnalytics.instance.logEvent(name: '미션내역_조회');
                Navigator.of(context).pushNamed(MissionHistoryScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: blackColor,
              ),
              title: const Text('설정'),
              onTap: () {
                Navigator.of(context).pushNamed(SettingsScreen.routeName);
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: blackColor,
              ),
              title: const Text('로그아웃'),
              onTap: () async {
                bool check;
                check = await _checkDialog(context, '로그아웃을 진행합니다');
                if (!check) return;
                try {
                  await authController.logout();
                  Navigator.of(context)
                      .pushReplacementNamed(AuthScreen.routeName);
                } catch (error) {
                  showPlatformBasedDialog(
                      context, '로그아웃에 실패했습니다', '다시 시도해주세요.');
                }
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_forever,
                color: blackColor,
              ),
              title: const Text('AMOND 계정 탈퇴'),
              onTap: () async {
                FirebaseAnalytics.instance.logEvent(name: '회원탈퇴_터치');
                bool check;
                check = await _checkDialog(context, 'AMOND 계정 탈퇴',
                    'AMOND 계정을 탈퇴하면 저장된 데이터들을 복구할 수 없습니다, 진행하시겠습니까?');
                if (!check) return;
                FirebaseAnalytics.instance.logEvent(name: '회원탈퇴');
                try {
                  final resignResponse = await context.read<DoAuth>().resign();
                  await authController.resign(resignResponse);
                  Navigator.of(context)
                      .pushReplacementNamed(AuthScreen.routeName);
                } catch (error) {
                  print(error);
                  showPlatformBasedDialog(
                      context, '회원탈퇴에 실패했습니다.', '다시 시도해주세요.');
                }
              },
            )
          ],
        ),
      ),
    );
  }

  /// 카메라 권한 확인
  ///
  /// 허락되면 [true], 거부되면 [false]를 반환
  // Future<bool> _getStatuses() async {
  //   Map<Permission, PermissionStatus> statuses =
  //       await [Permission.storage, Permission.camera].request();

  //   if (await Permission.camera.isGranted &&
  //       await Permission.storage.isGranted) {
  //     return Future.value(true);
  //   } else {
  //     return Future.value(false);
  //   }
  // }

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
