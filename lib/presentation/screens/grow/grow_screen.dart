import 'package:amond/presentation/controllers/grow_controller.dart';
import 'package:amond/presentation/controllers/name_validation.dart';
import 'package:amond/presentation/screens/grow/components/comment_box.dart';
import 'package:amond/presentation/screens/grow/components/level_system.dart';
import 'package:amond/presentation/screens/grow/components/mission_complete_dialog.dart';
import 'package:amond/presentation/screens/grow/components/shadow_button.dart';
import 'package:amond/presentation/screens/qr_scanner.dart';
import 'package:amond/utils/push_notification.dart';
import 'package:amond/widget/platform_based_indicator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'components/character_name_input.dart';

class GrowScreen extends StatelessWidget {
  static const screenMargin = 24.0;

  const GrowScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final growController = context.watch<GrowController>();

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final commentBoxHeight = height * 0.12;
    final buttonHeight = height * 0.08;

    // 데이터가 불러와 있지 않을때 데이터 불러오기
    if (growController.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        growController.fetchData();
      });
    }

    // 캐릭터의 이름이 정해져 있지 않으면 이름 설정 팝업을 띄운다.
    if (growController.isNewUser) {
      growController.isNewUser = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCharacterNamingPopup(context, growController.setCharacterName,
            growController.character.imageUrl);
      });
    }

    // 완료한 미션이 있으면 미션 완료 팝업을 띄운다.
    if (growController.increasedExp != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!Navigator.of(context).canPop()) {
          showMissionCompleteDialog(context, () async {
            await growController.increaseExp(growController.increasedExp!);
          }, growController.increasedExp!);
        }
      });
    }

    return growController.isLoading
        ? const Center(
            child: PlatformBasedIndicator(),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        screenMargin, 8.0, screenMargin, 0.0),
                    child: LevelSystem(
                      width: width,
                      height: 12.0,
                      level: growController.character.level,
                      currentExp: growController.character.currentExp,
                      maxExp: growController.character.maxExp,
                      percentage: growController.character.expPct,
                    ),
                  ),
                ],
              ),
              // 캐릭터 이름
              const SizedBox(height: 24),
              Text(growController.character.nickname ?? "",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500)),
              Text('(${growController.character.name})',
                  style: const TextStyle(color: Colors.grey)),
              // 캐릭터 이미지
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedOpacity(
                      opacity: growController.avatarIsVisible ? 1.0 : 0.0,
                      duration:
                          Duration(milliseconds: growController.fadeDuration),
                      child: GestureDetector(
                        onTap: () {
                          // FA 로그
                          FirebaseAnalytics.instance.logEvent(name: '캐릭터_터치');
                        },
                        child: Image.network(
                          growController.character.imageUrl,
                        ),
                      ),
                    ),
                    // 하트 버튼을 누르면 하트 표시
                    if (growController.isHeartVisible)
                      Lottie.asset(
                        'assets/lotties/lottie-hearts.json',
                        repeat: false,
                      ),
                    // 레벨업 시 레벨업 효과
                    if (growController.levelUpEffect)
                      Lottie.asset(
                        'assets/lotties/lottie-levelup.json',
                        repeat: false,
                      ),
                    // 최대 레벨 별빛 효과
                    if (growController.character.level == 4)
                      Lottie.asset(
                        'assets/lotties/maxlevel-starfall.json',
                        repeat: true,
                      )
                  ],
                ),
              ),
              Column(
                children: [
                  CommentBox(
                    comment: growController.comment,
                    width: width * 2 / 3,
                    height: commentBoxHeight,
                    // height: 100.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: screenMargin,
                      vertical: screenMargin / 1.5,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ShadowButton(
                            width: buttonHeight,
                            height: buttonHeight,
                            padding: EdgeInsets.zero,
                            onPress: growController.showHearts,
                            child: Center(
                              child: Image.asset(
                                'assets/images/heart_icon.png',
                                width: buttonHeight / 2,
                                height: buttonHeight / 2,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          // ShadowButton(
                          //   width: buttonHeight,
                          //   height: buttonHeight,
                          //   padding: EdgeInsets.zero,
                          //   onPress: () => growController.increaseExp(10),
                          //   child: Image.asset(
                          //     'assets/images/barcode_icon.png',
                          //     width: buttonHeight / 2,
                          //     height: buttonHeight / 2,
                          //   ),
                          // ),
                          ShadowButton(
                            width: buttonHeight,
                            height: buttonHeight,
                            padding: EdgeInsets.zero,
                            onPress: growController.changeComment,
                            child: Center(
                              child: Image.asset(
                                'assets/images/comment_icon.png',
                                width: buttonHeight / 2,
                                height: buttonHeight / 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
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

  /// QR Scanner로 이동 후 미션 성공 QR을 찍으면 해당 데이터를 반환
  ///
  /// then을 통해 미션성공 처리하면 된다.
  // Future<Object?> _toQrScanner(BuildContext context) async {
  //   await _getStatuses();
  //   var result = await Navigator.of(context).pushNamed(QrScanner.routeName);
  //   return result;
  // }

  // Future<void> _testqr(BuildContext context) async {
  //   await _getStatuses();
  //   final result = await Navigator.of(context).pushNamed(QrScanner.routeName);
  // }

  /// 캐릭터 이름 입력 팝업을 띄운다.
  void showCharacterNamingPopup(
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
            child: CharacterNameInput(onSubmit: onSubmit, imageUrl: imageUrl));
      },
    );
  }

  /// 미션 완료 다이얼로그를 띄운다.
  void showMissionCompleteDialog(
    BuildContext context,
    Function onSubmit,
    int reward,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return MissionCompleteDialog(onSubmit: onSubmit, reward: reward);
      },
    );
  }
}
