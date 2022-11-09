import 'package:amond/presentation/controllers/name_validation.dart';
import 'package:amond/presentation/screens/grow/components/character_name_input.dart';
import 'package:amond/utils/version/app_version.dart';
import 'package:amond/utils/version/notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';

Future<dynamic> showUpdateDialog(BuildContext context) {
    return showPlatformDialog(
        context: context,
        builder: (_) => BasicDialogAlert(
          title: const Text("새로운 기능이 추가되었어요"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Text(currentAppStatus.releaseNote),
            ],
          ),
          actions: <Widget>[
            BasicDialogAction(
              title: const Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            BasicDialogAction(
              title: const Text("업데이트"),
              onPressed: () {
                StoreRedirect.redirect(
                    androidAppId: "com.amond.amondApp",
                    iOSAppId: "1642916442");
              },
            ),
          ],
        ),
      );
  }

Future<dynamic> showNoticeDialog(BuildContext context) async {
    const String hideKey = 'hideNotice';
    // 하루동안 보지않기를 누른 시점

    final prefs = await SharedPreferences.getInstance();

    final hideWhen = prefs.getInt(hideKey);

    if (hideWhen != null) {
      Duration difference = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(hideWhen));
      if(difference.inDays < 1) {
        return;
      }
    }

    return showPlatformDialog(
        context: context,
        builder: (_) => BasicDialogAlert(
          title: const Text("공지사항이 있어요"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Text(appNotice.message),
            ],
          ),
          actions: <Widget>[
            BasicDialogAction(
              title: const Text("확인"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            BasicDialogAction(
              title: const Text("하루동안 보지않기"),
              onPressed: () {
                Navigator.pop(context);
                prefs.setInt(hideKey, DateTime.now().millisecondsSinceEpoch);
              },
            ),
          ],
        ),
      );
  }

