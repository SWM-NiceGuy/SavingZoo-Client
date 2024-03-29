import 'package:amond/presentation/controllers/grow/grow_view_model.dart';
import 'package:amond/presentation/widget/main_button.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';

class LevelupDialog extends StatelessWidget {
  const LevelupDialog({
    Key? key,
    required this.level,
    required this.name,
    this.isStageUpgrade = false,
    required this.stage,
    this.species,
  }) : super(key: key);

  final int level;
  final String name;
  final bool isStageUpgrade;
  final int stage;
  final String? species;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isStageUpgrade) {
        context.read<GrowViewModel>().fadeCharacter(true);
      }
    });

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(26.0))),
      child: SizedBox(
        width: deviceSize.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 상단 텍스트
                Text(
                  '레벨 $level 달성',
                  style: const TextStyle(fontSize: 20, color: textBlueColor200),
                ),
                const SizedBox(height: 34),

                // 중앙 이미지
                isStageUpgrade
                    ? Image.asset(
                        'assets/characters/$species/silhouettes/$stage.png',
                        width: 150,
                        height: 180,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/levelup_image.png',
                        width: 150,
                        height: 150,
                      ),

                const SizedBox(height: 44),

                // 하단 텍스트
                Text(
                  '레벨 $level 달성을 축하드립니다.',
                  style: const TextStyle(color: darkGreyColor, fontSize: 16),
                ),
                Text(
                  isStageUpgrade
                      ? '$name(이)가 새로운 모습으로 성장했어요!'
                      : '$name(이)가 한층 더 건강해졌어요!',
                  style: const TextStyle(color: darkGreyColor, fontSize: 16),
                ),

                const SizedBox(height: 29),

                // 확인 버튼
                MainButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (isStageUpgrade) {
                        context.read<GrowViewModel>().activateLevelUpEffect();
                        context.read<GrowViewModel>().fadeCharacter(false);
                      }
                      // 앱 리뷰 띄우기
                      if (level == 3) {
                        InAppReview.instance.isAvailable().then((_) {
                          InAppReview.instance.requestReview();
                        });
                      }
                    },
                    width: 149,
                    height: 56,
                    child: const Text('확인'))
              ]),
        ),
      ),
    );
  }
}
