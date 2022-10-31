import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/controllers/grow_view_model.dart';

import 'package:amond/presentation/screens/auth/auth_screen.dart';
import 'package:amond/presentation/screens/grow/components/character_image_widget.dart';
import 'package:amond/presentation/screens/grow/components/effects/heart_effect.dart';
import 'package:amond/presentation/screens/grow/components/effects/level_up_effect.dart';
import 'package:amond/presentation/screens/grow/components/effects/starfall_effect.dart';
import 'package:amond/presentation/screens/grow/components/feed_button.dart';
import 'package:amond/presentation/screens/grow/components/level_widget.dart';
import 'package:amond/presentation/screens/grow/components/play_button.dart';

import 'package:amond/presentation/screens/grow/components/play_timer.dart';
import 'package:amond/presentation/screens/grow/components/shadow_button.dart';
import 'package:amond/presentation/widget/platform_based_indicator.dart';
import 'package:amond/utils/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

import 'package:provider/provider.dart';

class GrowScreen extends StatelessWidget {
  const GrowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _GrowScreenWidget();
  }
}

class _GrowScreenWidget extends StatelessWidget {
  const _GrowScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final growController = context.watch<GrowViewModel>();

    // 데이터가 불러와 있지 않을때 데이터 불러오기
    if (growController.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        growController.fetchData().onError((error, stackTrace) {
          context.read<AuthController>().logout();
          showPlatformDialog(
            context: context,
            builder: (context) => BasicDialogAlert(
              title: const Text("로그인 실패"),
              content: const Text('다시 로그인 해주세요'),
              actions: <Widget>[
                BasicDialogAction(
                  title: const Text("확인"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context)
                        .pushReplacementNamed(AuthScreen.routeName);
                  },
                ),
              ],
            ),
          );
        });
      });
    }

    // 캐릭터의 이름이 정해져 있지 않으면 이름 설정 팝업을 띄운다.
    if (growController.isNewUser) {
      growController.isNewUser = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCharacterNamingDialog(context, growController.setCharacterName,
            growController.character.imageUrl);
      });
    }

    // 완료한 미션이 있으면 미션 완료 팝업을 띄운다.
    if (growController.isMissionClear) {
      growController.isMissionClear = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showMissionCompleteDialog(context, () async {
          await growController.increaseExp(growController.increasedExp!);
        }, growController.increasedExp!);
      });
    }

    return growController.isLoading
        ? const Center(
            child: PlatformBasedIndicator(),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 레벨 위젯
              const LevelWidget(),
              const SizedBox(height: 24),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: const [
                    // 캐릭터 이미지
                    CharacterImageWidget(),
                    // 최대 레벨 별빛 효과
                    StarfallEffect(),
                    // 하트 버튼을 누르면 하트 표시
                    HeartEffect(),
                    // 레벨업 시 레벨업 효과
                    LevelUpEffect(),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: FeedButton(
                      rewardQuantity: 3,
                      onClick: () {},
                      enabled: false,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: PlayButton(
                      remainingSeconds: growController.remainedPlayTime,
                      onClick: growController.playWithCharacter,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ],
          );
  }
}
