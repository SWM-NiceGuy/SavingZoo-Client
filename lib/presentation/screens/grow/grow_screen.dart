import 'package:amond/presentation/controllers/grow_controller.dart';
import 'package:amond/presentation/screens/grow/components/comment_box.dart';
import 'package:amond/presentation/screens/grow/components/level_system.dart';
import 'package:amond/presentation/screens/grow/components/mission_box.dart';
import 'package:amond/presentation/screens/grow/components/shadow_button.dart';
import 'package:amond/presentation/screens/grow/util/popup.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:word_break_text/word_break_text.dart';

class GrowScreen extends StatelessWidget {
  List<int> completedMissions = [];

  static const screenMargin = 24.0;

  GrowScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final growController = context.watch<GrowController>();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final missionBoxHeight = height * 0.1;
    final commentBoxHeight = height * 0.12;
    final buttonHeight = height * 0.09;

    void executeMissionComplete() {
      final completedMission = growController.missionCompleted;

      final title = completedMission == 1 ? 'Mission 1 성공' : 'Mission 2 성공';
      final content = completedMission == 1
          ? const WordBreakText(
              'Mission 2를 이어서 완수하시면 경험치를 획득하여 레벨업 하고 선구자 뱃지를 획득하실 수 있습니다!',
              style: missionCompletePopupTextStyle,
              wrapAlignment: WrapAlignment.center,
            )
          : Column(
              children: [
                const Text('선구자', style: missionCompletePopupTextStyle),
                const SizedBox(height: 8.0),
                Image.asset('assets/images/pioneer_badge_icon.png'),
              ],
            );

      if (completedMission > 0) {
        completedMissions.add(completedMission);
        showMissionCompletePopup(context, width, height, title, 30, content,
            () {
          growController.increaseExp(30);
        });
      }
    }

    if (growController.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        growController.fetchData();
      });
    }

    if (growController.isFirst) {
      Future.delayed(const Duration(seconds: 1), () {
        if (!Navigator.of(context).canPop()) {
          showMissionCompletePopup(
            context,
            width,
            height,
            '환경 보호를 위한 첫걸음',
            10,
            const WordBreakText(
              '환경을 지키겠다는 마음들이 모여 건강한 지구를 만들어가고 있어요!',
              style: missionCompletePopupTextStyle,
            ),
            () {
              growController.increaseExp(10);
            },
          );
        }
      });
      growController.isFirst = false;
    }

    return growController.isLoading
        ? const Center(child: CircularProgressIndicator())
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
                      currentExp: growController.currentExp,
                      maxExp: growController.maxExp,
                      percentage: growController.expPercentage,
                      leading: growController.hasBadge
                          ? Image.asset(
                              'assets/images/pioneer_badge_icon.png',
                              height: 32.0,
                            )
                          : null,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        MissionBox(
                          width: width * 0.75,
                          height: missionBoxHeight,
                          padding: const EdgeInsets.all(screenMargin),
                          isComplete: growController.missionCompleted >= 1,
                          title: 'Mission 1',
                          content: '공원 한바퀴',
                          imagePath: 'assets/images/shoe_icon.png',
                        ),
                        MissionBox(
                          width: width * 0.75,
                          height: missionBoxHeight,
                          padding: const EdgeInsets.fromLTRB(
                            0.0,
                            screenMargin,
                            screenMargin,
                            screenMargin,
                          ),
                          isComplete: growController.missionCompleted >= 2,
                          title: 'Mission 2',
                          content: '플로깅',
                          imagePath: 'assets/images/plogging_icon.png',
                        ),
                      ],
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
                        growController.avatarPath,
                        // height: 180.0,
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
                          onPress: executeMissionComplete,
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
}
