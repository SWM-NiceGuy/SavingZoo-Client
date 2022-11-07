import 'package:amond/data/repository/character_repository_impl.dart';
import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/controllers/grow_controller.dart';

import 'package:amond/presentation/screens/auth/auth_screen.dart';
import 'package:amond/presentation/screens/grow/components/character_image_widget.dart';
import 'package:amond/presentation/screens/grow/components/comment_box.dart';
import 'package:amond/presentation/screens/grow/components/effects/heart_effect.dart';
import 'package:amond/presentation/screens/grow/components/effects/level_up_effect.dart';
import 'package:amond/presentation/screens/grow/components/effects/starfall_effect.dart';
import 'package:amond/presentation/screens/grow/components/level_widget.dart';

import 'package:amond/presentation/screens/grow/components/play_timer.dart';
import 'package:amond/presentation/screens/grow/components/shadow_button.dart';
import 'package:amond/utils/dialogs/dialogs.dart';
import 'package:amond/widget/platform_based_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

import 'package:provider/provider.dart';

class GrowScreen extends StatelessWidget {
  const GrowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          GrowController(context.read<CharacterRepositoryImpl>()),
      child: const GrowScreenWidget(),
    );
  }
}

class GrowScreenWidget extends StatelessWidget {
  static const screenMargin = 24.0;

  const GrowScreenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final growController = Provider.of<GrowController>(context, listen: false);
    final growController = context.watch<GrowController>();

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final commentBoxHeight = height * 0.12;
    final buttonHeight = height * 0.08;

    // 데이터가 불러와 있지 않을때 데이터 불러오기
    if (growController.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
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
              // 캐릭터 이름
              const SizedBox(height: 24),
              Text(growController.character.nickname ?? "",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500)),
              Text('(${growController.character.name})',
                  style: const TextStyle(color: Colors.grey)),
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                  ShadowButton(
                                    width: buttonHeight,
                                    height: buttonHeight,
                                    padding: EdgeInsets.zero,
                                    onPress: growController.playButtonEnabled
                                        ? growController.playWithCharacter
                                        : null,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/heart_icon.png',
                                        width: buttonHeight / 2,
                                        height: buttonHeight / 2,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -45,
                                    child: PlayTimer(
                                      time: growController.remainedPlayTime,
                                      width: buttonHeight,
                                    ),
                                  ),
                                ],
                              ),
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
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          );
  }
}
