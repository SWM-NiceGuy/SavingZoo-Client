import 'package:amond/presentation/controllers/name_validation.dart';
import 'package:amond/presentation/screens/grow/components/character_name_input.dart';
import 'package:amond/utils/version/app_version.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:provider/provider.dart';
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
              Text('${currentAppStatus?.releaseNote}'),
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

  /// 캐릭터 이름 입력 다이얼로그를 띄운다.
  void showCharacterNamingDialog(
    BuildContext context,
    Function(String) onSubmit,
    String imageUrl,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ChangeNotifierProvider(
            create: (_) => NameValidation(),
            child: WillPopScope(
                onWillPop: () async => false,
                child: CharacterNameInput(
                    onSubmit: onSubmit, imageUrl: imageUrl)));
      },
    );
  }

  /// 미션 완료 다이얼로그를 띄운다.
  // void showMissionCompleteDialog(
  //   BuildContext context,
  //   Function onSubmit,
  //   int reward,
  // ) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       return MissionCompleteDialog(onSubmit: onSubmit, reward: reward);
  //     },
  //   );
  // }