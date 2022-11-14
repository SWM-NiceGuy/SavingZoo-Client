import 'dart:io';

import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/screens/auth/auth_screen.dart';
import 'package:amond/ui/text_styles.dart';
import 'package:amond/utils/auth/do_auth.dart';
import 'package:amond/presentation/widget/show_platform_based_dialog.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoSettings extends StatelessWidget {
  const UserInfoSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원 정보 수정'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Image.asset('assets/images/sign_out_icon.png', width: 24, height: 24),
            title: const Text('회원탈퇴', style: settingsTextStyle),
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

