import 'dart:io';

import 'package:amond/utils/version/app_version.dart';
import 'package:amond/utils/version/notice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_redirect/store_redirect.dart';

class PleaseUpdateScreen extends StatelessWidget {
  const PleaseUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!Navigator.of(context).canPop()) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            // 업데이트 팝업
            if (currentAppStatus.required) {
              return Platform.isIOS
                  // iOS 팝업
                  ? CupertinoAlertDialog(
                      title: const Text("업데이트가 필요합니다."),
                      content: Column(
                        children: [
                          const Text("현재버전 : $appVersion"),
                          Text("최신버전 : ${currentAppStatus.latestVersion}")
                        ],
                      ),
                      actions: [
                        CupertinoButton(
                            child: const Text("확인"),
                            onPressed: () {
                              StoreRedirect.redirect(
                                  androidAppId: "com.amond.amondApp",
                                  iOSAppId: "1642916442");
                            })
                      ],
                    )
                  // Android 팝업
                  : WillPopScope(
                      onWillPop: () async => false,
                      child: AlertDialog(
                        title: const Text("업데이트가 필요합니다."),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("현재버전 : $appVersion"),
                            Text("최신버전 : ${currentAppStatus.latestVersion}")
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                StoreRedirect.redirect(
                                    androidAppId: "com.amond.amondApp",
                                    iOSAppId: "1642916442");
                              },
                              child: const Text("확인"))
                        ],
                      ),
                    );
            }
            // 공지사항 팝업
            else {
              return Platform.isIOS
                  // iOS 팝업
                  ? CupertinoAlertDialog(
                      title: const Text("공지사항"),
                      content: Column(
                        children: [
                          Text(appNotice.message ?? ''),
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
                  : WillPopScope(
                      onWillPop: () async => false,
                      child: AlertDialog(
                        title: const Text("공지사항"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(appNotice.message ?? ''),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                              child: const Text("확인"))
                        ],
                      ),
                    );
            }
          },
        );
      }
    });
    return const Scaffold();
  }
}
