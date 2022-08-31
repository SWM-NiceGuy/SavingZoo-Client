import 'package:amond/presentation/controllers/grow_controller.dart';
import 'package:amond/presentation/screens/grow/components/comment_box.dart';
import 'package:amond/presentation/screens/grow/components/level_system.dart';
import 'package:amond/presentation/screens/grow/components/mission_box.dart';
import 'package:amond/presentation/screens/grow/components/shadow_button.dart';
import 'package:amond/presentation/screens/grow/util/popup.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class GrowScreen extends StatelessWidget {
  bool isNewUser;
  List<int> completedMissions = [];

  static const screenMargin = 24.0;

  GrowScreen({
    Key? key,
    required this.isNewUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final growController = context.watch<GrowController>();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final missionBoxHeight = height * 0.1;
    final avatarHeight = height * 0.2;
    final commentBoxHeight = height * 0.12;
    final buttonHeight = height * 0.09;

    void executeMissionComplete() {
      final title =
          !completedMissions.contains(1) ? 'Mission 1 성공' : 'Mission 2 성공';
      final content = !completedMissions.contains(1)
          ? 'Mission 2를 이어서 완수하시면 경험치를 획득하여 레벨업 하고 선구자 뱃지를 획득하실 수 있습니다!'
          : '모든 미션을 완수하셨습니다. 감사의 의미로 선구자 뱃지를 드립니다';

      completedMissions.add(!completedMissions.contains(1) ? 1 : 2);

      showMissionCompletePopup(context, width, height, title, 30, content, () {
        growController.increaseExp(30);
      });
    }

    if (isNewUser) {
      isNewUser = false;
      Future.delayed(Duration(seconds: 1), () {
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: screenMargin),
              child: LevelSystem(
                width: width,
                height: 12.0,
                level: growController.level,
                currentExp: growController.currentExp,
                maxExp: growController.maxExp,
                percentage: growController.expPercentage,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: screenMargin,
              ),
              child: Row(
                children: [
                  MissionBox(
                    width: width * 0.75,
                    height: missionBoxHeight,
                    isComplete: completedMissions.contains(1),
                    title: 'Mission 1',
                    content: '공원 한바퀴',
                    imagePath: 'assets/images/shoes.png',
                  ),
                  MissionBox(
                    width: width * 0.75,
                    height: missionBoxHeight,
                    isComplete: completedMissions.contains(2),
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
              duration: Duration(milliseconds: growController.fadeDuration),
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
              padding: const EdgeInsets.all(screenMargin).copyWith(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShadowButton(
                    width: buttonHeight,
                    height: buttonHeight,
                    onPress: growController.showHearts,
                    child: Icon(
                      Icons.heart_broken,
                      size: buttonHeight / 2,
                      color: Color(0xFFEFAFA6),
                    ),
                  ),
                  ShadowButton(
                    width: buttonHeight,
                    height: buttonHeight,
                    onPress: executeMissionComplete,
                    child: Icon(
                      Icons.qr_code_scanner,
                      size: buttonHeight / 2,
                      color: Color(0xFF757679),
                    ),
                  ),
                  ShadowButton(
                    width: buttonHeight,
                    height: buttonHeight,
                    onPress: growController.changeComment,
                    child: Icon(
                      Icons.chat_bubble,
                      size: buttonHeight / 2,
                      color: Color(0xFFC4D96F),
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
