import 'dart:io';

import 'package:amond/utils/app_version.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PleaseUpdateScreen extends StatelessWidget {
  const PleaseUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      if (!Navigator.of(context).canPop()) {
        showDialog(
          context: context,
          builder: (context) {
            return Platform.isIOS
                // iOS 팝업
                ? CupertinoAlertDialog(
                    title: const Text("업데이트가 필요합니다."),
                    content: Column(
                      children: [
                        const Text("현재버전 : $appVersion"),
                        Text("최신버전 : $latestVersion")
                      ],
                    ),
                    actions: [
                      CupertinoButton(
                          child: const Text("확인"),
                          onPressed: () {
                            exit(0);
                          })
                    ],
                  )
                // Android 팝업
                : AlertDialog(
                    title: const Text("업데이트가 필요합니다."),
                    content: Column(
                      children: [
                        const Text("현재버전 : $appVersion"),
                        Text("최신버전 : $latestVersion")
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          child: const Text("확인"))
                    ],
                  );
          },
        );
      }
    });
    return const Scaffold();
  }
}
