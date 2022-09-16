import 'package:amond/presentation/controllers/grow_controller.dart';
import 'package:amond/presentation/controllers/mission_controller.dart';
import 'package:amond/presentation/screens/grow/components/level_system.dart';
import 'package:amond/presentation/screens/grow/components/shadow_button.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MissionCompleteDialog extends StatelessWidget {
  MissionCompleteDialog({
    Key? key,
    required this.missionId,
    required this.reward,
  }) : super(key: key);

  final int missionId;
  final int reward;

  bool isIncreased = false;

  @override
  Widget build(BuildContext context) {
    final growController = context.watch<GrowController>();
    if (!isIncreased) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        isIncreased = true;
        growController.increaseExp(reward);
      });
    }
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      insetPadding: const EdgeInsets.all(40),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "미션 완료!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "+${reward}XP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            LevelSystem(
              width: MediaQuery.of(context).size.width,
              height: 12.0,
              level: growController.character.level,
              currentExp: growController.character.displayExp,
              maxExp: growController.character.maxExp,
              percentage: growController.character.expPercentage,
              leading: null,
            ),
            const SizedBox(height: 24),
            Text(growController.characterName ?? "",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            Text('(${growController.character.avatar.nickname})',
                style: TextStyle(color: Colors.grey)),
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
                ],
              ),
            ),
            ShadowButton(
              width: 80,
              height: 40,
              borderRadius: 10,
              onPress: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Text(
                  '확인',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: expTextColor,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
