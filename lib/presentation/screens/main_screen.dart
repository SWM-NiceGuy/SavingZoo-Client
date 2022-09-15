import 'dart:io';

import 'package:amond/domain/repositories/mission_repository.dart';
import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/controllers/mission_controller.dart';
import 'package:amond/presentation/screens/auth/auth_screen.dart';
import 'package:amond/presentation/screens/mission/mission_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:amond/presentation/screens/grow/grow_screen.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../data/repository/mission_repository_impl.dart';

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
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: bottomNavigationBarScreens[_screenIndex],
      ),
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home_filled)),
            BottomNavigationBarItem(
                label: '미션', icon: Icon(Icons.track_changes_outlined))
          ],
          onTap: (index) {
            setState(() {
              _screenIndex = index;
            });
          },
          currentIndex: _screenIndex,
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
                  _showLogoutFailDialog(context, '로그아웃에 실패했습니다');
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
                bool check;
                check = await _checkDialog(context, 'AMOND 계정 탈퇴',
                    'AMOND 계정을 탈퇴하면 저장된 데이터들을 복구할 수 없습니다, 진행하시겠습니까?');
                if (!check) return;
                try {
                  await authController.resign();
                  Navigator.of(context)
                      .pushReplacementNamed(AuthScreen.routeName);
                } catch (error) {
                  _showLogoutFailDialog(context, '회원탈퇴에 실패했습니다.');
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
  Future<bool> _getStatuses() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage, Permission.camera].request();

    if (await Permission.camera.isGranted &&
        await Permission.storage.isGranted) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  void _showLogoutFailDialog(BuildContext context, String errMsg) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text(errMsg),
            content: const Text('다시 시도해주세요.'),
            actions: [
              CupertinoDialogAction(
                child: const Text('확인'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(errMsg),
            content: const Text('다시 시도해주세요.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    }
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
