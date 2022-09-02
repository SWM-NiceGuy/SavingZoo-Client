import 'dart:io';

import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/screens/auth/auth_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:amond/presentation/screens/grow/grow_screen.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'qr_scanner.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String routeName = '/main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final authController = context.read<AuthController>();
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: blackColor,
                ),
                title: const Text(
                  '로그아웃',
                  style: TextStyle(color: blackColor),
                ),
                onTap: () async {
                  try {
                    await authController.logout();
                    Navigator.of(context)
                        .pushReplacementNamed(AuthScreen.routeName);
                  } catch (error) {
                    _showLogoutFailDialog(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete_forever,
                  color: blackColor,
                ),
                title: const Text(
                  'AMOND 탈퇴',
                  style: TextStyle(color: blackColor),
                ),
                onTap: () async {
                  try {
                    await authController.resign();
                    Navigator.of(context)
                        .pushReplacementNamed(AuthScreen.routeName);
                  } catch (error) {
                    _showLogoutFailDialog(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: Color(0xFF96CE5F)),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: GrowScreen(),
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

  void _toQrScanner() async {
    await _getStatuses();
    Navigator.of(context).pushNamed(QrScanner.routeName);
  }

  void _showLogoutFailDialog(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('로그아웃에 실패하였습니다'),
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
            title: const Text('로그아웃에 실패하였습니다'),
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
}
