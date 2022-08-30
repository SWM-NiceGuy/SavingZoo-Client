import 'package:amond/presentation/controllers/grow_controller.dart';
import 'package:amond/presentation/screens/grow/components/comment_box.dart';
import 'package:amond/presentation/screens/grow/components/level_system.dart';
import 'package:amond/presentation/screens/grow/components/mission_box.dart';
import 'package:amond/presentation/screens/grow/components/shadow_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GrowScreen extends StatelessWidget {
  const GrowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final growController = context.watch<GrowController>();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final missionBoxHeight = height * 0.1;
    final avatarHeight = height * 0.2;
    final commentBoxHeight = height * 0.12;
    final buttonHeight = height * 0.09;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            LevelSystem(
              width: width,
              height: 12.0,
              level: growController.level,
              currentExp: growController.currentExp,
              maxExp: growController.maxExp,
              percentage: growController.expPercentage,
            ),
            const SizedBox(height: 8.0),
            MissionBox(
              width: width,
              height: missionBoxHeight,
              title: 'Mission 1',
              content: '공원 한바퀴',
              imagePath: 'assets/images/shoes.png',
            ),
          ],
        ),
        AnimatedOpacity(
          opacity: growController.avatarIsVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: growController.fadeDuration),
          child: Image.asset(
            growController.avatarPath,
            height: avatarHeight,
            // height: 180.0,
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
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShadowButton(
                  width: buttonHeight,
                  height: buttonHeight,
                  onPress: () => growController.increaseExp(10),
                  child: Icon(
                    Icons.heart_broken,
                    size: buttonHeight / 2,
                    color: Color(0xFFEFAFA6),
                  ),
                ),
                ShadowButton(
                  width: buttonHeight,
                  height: buttonHeight,
                  onPress: () {},
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
          ],
        ),
      ],
    );
  }
}
