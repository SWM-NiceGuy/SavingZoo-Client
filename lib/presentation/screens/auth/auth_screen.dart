import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/screens/main_screen.dart';

import 'components/kakao_login_container.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const String routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
    // 토큰이 존재하면 MainScreen으로 이동
    if (context.read<AuthController>().isTokenExists) {
      _navigateToMainScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.read<AuthController>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                try {
                  // 로그인 시도 후 성공하면 MainScreen으로 이동
                  await authController.loginWithKakaoApp();
                  _navigateToMainScreen();
                } catch (error) {
                  // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                  // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                  if (error is PlatformException && error.code == 'CANCELED') {
                    return;
                  } else {
                    // 로그인 실패
                    _showLoginFailDialog(context);
                  }
                }
              },
              child: const KakaoLoginContainer(),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToMainScreen() {
    Navigator.of(context).pushNamed(MainScreen.routeName);
  }

  void _showLoginFailDialog(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('로그인에 실패하였습니다'),
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
            title: const Text('로그인에 실패하였습니다'),
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


