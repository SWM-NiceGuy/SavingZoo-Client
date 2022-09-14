import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/controllers/grow_controller.dart';
import 'package:amond/presentation/screens/grow/components/comment_box.dart';
import 'package:amond/presentation/screens/grow/components/level_system.dart';
import 'package:amond/presentation/screens/grow/components/mission_box.dart';
import 'package:amond/presentation/screens/grow/components/shadow_button.dart';
import 'package:amond/presentation/screens/grow/util/mission.dart';
import 'package:amond/presentation/screens/grow/util/popup.dart';
import 'package:amond/presentation/screens/qr_scanner.dart';
import 'package:amond/widget/platform_based_indicator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:word_break_text/word_break_text.dart';

class GrowScreen extends StatelessWidget {
  static const screenMargin = 24.0;

  const GrowScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final growController = context.watch<GrowController>();
    final memberInfo = context.read<AuthController>().memberInfo!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final missionBoxHeight = height * 0.1;
    final commentBoxHeight = height * 0.12;
    final buttonHeight = height * 0.08;

    // 데이터가 불러와 있지 않을때 데이터 불러오기
    if (!growController.isDataFetched) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        growController.fetchData(memberInfo);
      });
    }

      final missionCompletePopupTextStyle = Theme.of(context)
          .textTheme
          .bodyText1
          ?.copyWith(fontSize: 16.0, height: 1.5);

      void executeMissionComplete(int completedMission) {

        final title = completedMission == 1 ? 'Mission 1 완수' : 'Mission 2 완수';
        final content = completedMission == 1
            ? WordBreakText(
                'Mission 2를 이어서 완수하시면 경험치를 획득하여 레벨업 하고 선구자 뱃지를 획득하실 수 있습니다!',
                style: missionCompletePopupTextStyle,
                wrapAlignment: WrapAlignment.center,
              )
            : Column(
                children: [
                  Text('선구자', style: missionCompletePopupTextStyle),
                  const SizedBox(height: 8.0),
                  Image.asset('assets/images/pioneer_badge_icon.png'),
                ],
              );

        if (completedMission > 0) {
          showMissionCompletePopup(context, width, height, title, 30, content,
              () {
            growController.increaseExp(30);
          });
        }
      }

      if (growController.isNewUser) {
        growController.isNewUser = false;
        Future.delayed(const Duration(seconds: 1), () {
          if (!Navigator.of(context).canPop()) {
            showMissionCompletePopup(
              context,
              width,
              height,
              '환경 보호를 위한 첫걸음',
              10,
              WordBreakText(
                '환경을 지키겠다는 마음들이 모여 건강한 지구를 만들어가고 있어요!',
                style: missionCompletePopupTextStyle,
              ),
              () {
                growController.increaseExp(10);
              },
            );
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
                        currentExp: growController.character.displayExp,
                        maxExp: growController.character.maxExp,
                        percentage: growController.character.expPercentage,
                        leading: growController.hasBadge
                            ? Image.asset(
                                'assets/images/pioneer_badge_icon.png',
                                height: 32.0,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: growController.avatarIsVisible ? 1.0 : 0.0,
                        duration:
                            Duration(milliseconds: growController.fadeDuration),
                        child: Image.asset(
                          growController.character.avatarPath,
                        ),
                      ),
                      growController.heartsIsVisible
                          ? Lottie.asset(
                              'assets/lotties/lottie-hearts.json',
                              repeat: false,
                            )
                          : const SizedBox(),
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
                        vertical: screenMargin / 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShadowButton(
                            width: buttonHeight,
                            height: buttonHeight,
                            padding: EdgeInsets.zero,
                            onPress: growController.showHearts,
                            child: Image.asset(
                              'assets/images/heart_icon.png',
                              width: buttonHeight / 2,
                              height: buttonHeight / 2,
                            ),
                          ),
                          ShadowButton(
                            width: buttonHeight,
                            height: buttonHeight,
                            padding: EdgeInsets.zero,
                            // onPress: () => _toQrScanner(context).then((mission) {
                            //   if (mission == null) return;

                            //   if (mission == Mission.first) {
                            //     if (growController.missionCompleted >= 1) return;
                            //     growController.changeMissionCompleted(1);
                            //     executeMissionComplete(1);
                            //   } else if (mission == Mission.second) {
                            //     if (growController.missionCompleted >= 2) return;
                            //     growController.changeMissionCompleted(2);
                            //     executeMissionComplete(2);
                            //   }
                            // }),
                            onPress: () => growController.increaseExp(10),
                            child: Image.asset(
                              'assets/images/barcode_icon.png',
                              width: buttonHeight / 2,
                              height: buttonHeight / 2,
                            ),
                          ),
                          ShadowButton(
                            width: buttonHeight,
                            height: buttonHeight,
                            padding: EdgeInsets.zero,
                            onPress: growController.changeComment,
                            child: Image.asset(
                              'assets/images/comment_icon.png',
                              width: buttonHeight / 2,
                              height: buttonHeight / 2,
                            ),
                          ),
                        ],
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
    Future<Object?> _toQrScanner(BuildContext context) async {
      await _getStatuses();
      var result = await Navigator.of(context).pushNamed(QrScanner.routeName);
      return result;
    }

    Future<void> _testqr(BuildContext context) async {
      await _getStatuses();
      final result = await Navigator.of(context).pushNamed(QrScanner.routeName);
      print('result is : ');
      print(result.runtimeType);
    }
  }
