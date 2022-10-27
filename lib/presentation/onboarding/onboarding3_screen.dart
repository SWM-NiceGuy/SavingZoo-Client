import 'dart:async';
import 'dart:io';

import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/onboarding/components/main_button.dart';
import 'package:amond/presentation/screens/auth/components/apple_login_container.dart';
import 'package:amond/presentation/screens/auth/components/kakao_login_container.dart';
import 'package:amond/presentation/screens/main_screen.dart';
import 'package:amond/ui/colors.dart';
import 'package:amond/utils/auth/do_apple_auth.dart';
import 'package:amond/utils/auth/do_kakao_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Onboarding3Screen extends StatefulWidget {
  const Onboarding3Screen({Key? key}) : super(key: key);

  @override
  State<Onboarding3Screen> createState() => _Onboarding3ScreenState();
}

class _Onboarding3ScreenState extends State<Onboarding3Screen> {
  late TextEditingController _controller;
  var _isNameSet = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('3/3'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: SizedBox(
                height: deviceSize.height -
                    (MediaQuery.of(context).padding.top +
                        MediaQuery.of(context).padding.bottom +
                        kToolbarHeight),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      _isNameSet
                          ? '로그인을 통해\n${_controller.text}와 함께해주세요'
                          : '보살핌이 필요한 수달이\n보호소에 찾아왔어요!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: darkGreyColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 70),
                    Image.asset(
                      'assets/images/onboarding2.png',
                      width: deviceSize.width * 0.5,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 50),
                    if(!_isNameSet)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: lightGreyColor),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        onEditingComplete: () => setState(() {}),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (!_isNameSet)
                    const Text(
                      '사육사님이 돌봐줄 동물의\n이름을 지어주세요!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: greyColor, fontSize: 16),
                    ),
                    if (_isNameSet)
                    _loginColumn(context.read<AuthController>()),
                    const Spacer(),
                    if (!_isNameSet)
                      MainButton(
                          width: deviceSize.width * 0.8,
                          height: 60,
                          // onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (_) => const ())),
                          onPressed: _controller.text.isEmpty
                              ? null
                              : () {
                                  setState(() {
                                    _isNameSet = true;
                                  });
                                },
                          child: const Text(
                            '시작하기',
                            style: TextStyle(fontSize: 16),
                          )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginColumn(AuthController authController) {
    return Column(
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
                    await authController.login(info.provider, info.accessToken);
                    _navigateToMainScreen();
                  } catch (error) {
                    // 의도적인 로그인 취소로 보고 애플 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                    if (error is SignInWithAppleAuthorizationException &&
                        error.code == AuthorizationErrorCode.canceled) {
                      return;
                    }
                    _showLoginFailDialog(context, '로그인에 실패했습니다.');
                  }
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
                  await authController.login(info.provider, info.accessToken);
                  _navigateToMainScreen();
                } catch (error) {
                  // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                  // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                  if (error is PlatformException && error.code == 'CANCELED') {
                    return;
                  } else if (error is TimeoutException) {
                    _showLoginFailDialog(context, '로그인 시간이 초과되었습니다.');
                  } else {
                    // 로그인 실패
                    _showLoginFailDialog(context, '로그인에 실패했습니다.');
                  }
                }
              },
              child: const KakaoLoginContainer(),
            ),
          ],
        ),
      ],
    );
  }

  /// MainScreen으로 pushReplacement하는 함수
  void _navigateToMainScreen() {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) => const MainScreen(),
        settings: const RouteSettings(name: "/")),(Route<dynamic> route) => false);
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
