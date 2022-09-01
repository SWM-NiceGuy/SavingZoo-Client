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

class GrowScreen extends StatelessWidget {

  static const screenMargin = 24.0;

  GrowScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final growController = context.watch<GrowController>();
    final memberInfo = context.read<AuthController>().memberInfo!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final missionBoxHeight = height * 0.1;
    final avatarHeight = height * 0.2;
    final commentBoxHeight = height * 0.12;
    final buttonHeight = height * 0.09;

    // 데이터가 불러와 있지 않을때 데이터 불러오기
    if (!growController.isDataFetched) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        growController.fetchData(memberInfo);
      });
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
            '환경을 지키겠다는 마음들이 모여 건강한 지구를 만들어가고 있어요!',
            () {
              growController.increaseExp(10);
            },
          );
        }
      });
    }

    return growController.isLoading
        ? const Center(child: PlatformBasedIndicator())
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
                      level: growController.level,
                      currentExp: growController.displayExp,
                      maxExp: growController.maxExp,
                      percentage: growController.expPercentage,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 8.0),
                    child: Row(
                      children: [
                        MissionBox(
                          width: width * 0.75,
                          height: missionBoxHeight,
                          isComplete: growController.missionCompleted >= 1,
                          title: 'Mission 1',
                          content: '공원 한바퀴',
                          imagePath: 'assets/images/shoes.png',
                        ),
                        MissionBox(
                          width: width * 0.75,
                          height: missionBoxHeight,
                          isComplete: growController.missionCompleted >= 2,
                          title: 'Mission 2',
                          content: '플로깅',
                          imagePath: 'assets/images/plogging.png',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: growController.avatarIsVisible ? 1.0 : 0.0,
                    duration:
                        Duration(milliseconds: growController.fadeDuration),
                    child: Image.asset(
                      growController.avatarPath,
                      height: avatarHeight,
                      // height: 180.0,
                    ),
                  ),
                  growController.heartsIsVisible
                      ? Lottie.asset(
                          'assets/lotties/lottie-hearts.json',
                          height: avatarHeight * 1.5,
                          repeat: false,
                        )
                      : const SizedBox(),
                ],
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
                    padding:
                        const EdgeInsets.all(screenMargin).copyWith(top: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 하트
                        ShadowButton(
                          width: buttonHeight,
                          height: buttonHeight,
                          onPress: growController.showHearts,
                          child: Image.asset(
                            'assets/images/heart_icon.png',
                            width: buttonHeight / 2,
                            height: buttonHeight / 2,
                          ),
                        ),
                        // QR 코드
                        ShadowButton(
                          width: buttonHeight,
                          height: buttonHeight,
                          onPress: () => _toQrScanner(context).then((mission) {
                            if (mission == null) return;
                            // 미션 성공시
                            if (mission == Mission.first) {
                              // 이미 1을 완수 했을시
                              if (growController.missionCompleted >= 1) {
                                return;
                              }
                              // 미션1 완수 후
                              growController.changeMissionCompleted(1);
                            } else if (mission == Mission.second) {
                              // 이미 2를 완수 했을시
                              if (growController.missionCompleted >= 2) {
                                return;
                              }
                              // 미션2 완수 후
                            }
                          }),
                          child: Image.asset(
                            'assets/images/barcode_icon.png',
                            width: buttonHeight / 2,
                            height: buttonHeight / 2,
                          ),
                        ),
                        // 코멘트
                        ShadowButton(
                          width: buttonHeight,
                          height: buttonHeight,
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
