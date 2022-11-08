import 'dart:async';
import 'dart:io';

import 'package:amond/presentation/screens/auth/components/apple_login_container.dart';
import 'package:amond/presentation/screens/auth/components/kakao_login_container.dart';
import 'package:amond/presentation/screens/main_or_onboarding_screen.dart';
import 'package:amond/presentation/screens/onboarding/onboarding1_screen.dart';
import 'package:amond/ui/colors.dart';
import 'package:amond/utils/auth/do_apple_auth.dart';
import 'package:amond/utils/auth/do_kakao_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/screens/main_screen.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const String routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final authController = context.read<AuthController>();
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  fit: BoxFit.cover,
                ),
                const Text(
                  'Amond',
                  style: TextStyle(color: blackColor, fontSize: 32),
                ),
                const Spacer(),
                const Text(
                  '겸사겸사 미션을 통해\n멸종위기 동물을 돌봐주세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 60),
                Column(
                  children: [
                    const SizedBox(height: 12.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 애플 로그인 버튼
                        if (Platform.isIOS)
                          GestureDetector(
                            onTap: () async {
                              try {
                                // 로그인 시도 후 성공하면 MainScreen으로 이동
                                final info = await DoAppleAuth().login();
                                await authController.login(info);
                              } catch (error) {
                                // 의도적인 로그인 취소로 보고 애플 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                                if (error
                                        is SignInWithAppleAuthorizationException &&
                                    error.code ==
                                        AuthorizationErrorCode.canceled) {
                                  return;
                                }
                                _showLoginFailDialog(context, '로그인에 실패했습니다.');
                              }
                              _navigateToFirstScreen();
                            },
                            child: const AppleLoginContainer(),
                          ),
                        if (Platform.isIOS) const SizedBox(height: 18),

                        // 카카오 로그인 버튼
                        GestureDetector(
                          onTap: () async {
                            try {
                              // 로그인 시도 후 성공하면 MainScreen으로 이동
                              final info = await DoKakaoAuth().login();
                              await authController.login(info);
                            } catch (error) {
                              //   // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                              //   // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                              if (error is PlatformException &&
                                  error.code == 'CANCELED') {
                                return;
                              } else if (error is TimeoutException) {
                                _showLoginFailDialog(
                                    context, '로그인 시간이 초과되었습니다.');
                              } else {
                                // 로그인 실패
                                _showLoginFailDialog(context, '로그인에 실패했습니다.');
                              }
                            }
                            _navigateToFirstScreen();
                          },
                          child: const KakaoLoginContainer(),
                        ),
                        const SizedBox(height: 18),
                        GestureDetector(
                          child: const Text(
                            '로그인 없이 이용해보기',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const Onboarding1Screen())),
                        ),
                      ],
                    ),
                  ],
                )
                // 카카오 로그인 버튼
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// MainScreen으로 pushReplacement하는 함수
  void _navigateToFirstScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MainOrOnboardingScreen(),
        settings: const RouteSettings(name: "/")));
    // Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
  }

  /// 로그인 실패시 Dialog를 보여주는 함수
  void _showLoginFailDialog(BuildContext context, String errorMsg) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text(errorMsg),
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
            title: Text(errorMsg),
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

class LogoImage extends StatelessWidget {
  const LogoImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Image.asset(
      'assets/images/first_apple_avatar.png',
      width: deviceSize.width * 0.5,
      height: deviceSize.width * 0.5,
      fit: BoxFit.cover,
    );
  }
}
