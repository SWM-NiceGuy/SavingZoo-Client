import 'dart:async';

import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/controllers/grow/grow_view_model.dart';

import 'package:amond/presentation/screens/grow/components/character_image_widget.dart';
import 'package:amond/presentation/screens/grow/components/effects/fish_effect.dart';
import 'package:amond/presentation/screens/grow/components/effects/heart_effect.dart';
import 'package:amond/presentation/screens/grow/components/effects/stage_up_effect.dart';
import 'package:amond/presentation/screens/grow/components/feed_button.dart';
import 'package:amond/presentation/screens/grow/components/level_widget.dart';

import 'package:amond/presentation/screens/grow/components/play_button.dart';
import 'package:amond/presentation/screens/grow/grow_history_screen.dart';
import 'package:amond/presentation/screens/grow/memorial_screen.dart';
import 'package:amond/presentation/screens/mission/util/check_mission_result.dart';
import 'package:amond/presentation/widget/dialogs/levelup_dialog.dart';

import 'package:amond/presentation/widget/platform_based_indicator.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class GrowScreen extends StatefulWidget {
  const GrowScreen({Key? key}) : super(key: key);

  @override
  State<GrowScreen> createState() => _GrowScreenState();
}

class _GrowScreenState extends State<GrowScreen> {
  StreamSubscription? _uiEventSubscription;

  @override
  void initState() {
    super.initState();

    final viewModel = context.read<GrowViewModel>();

    // 뷰모델로 부터 레벨업 이벤트를 받으면 레벨업 다이얼로그 보여주기
    _uiEventSubscription = viewModel.eventStream.listen((event) {
      event.when(
        levelUp: () {
          showDialog(
              context: context,
              builder: (_) => LevelupDialog(
                    level: viewModel.character.level,
                    name: viewModel.character.nickname ?? '',
                    stage: viewModel.character.currentStage,
                  ));
        },
        stageUp: () {
          showDialog(
              context: context,
              builder: (_) => LevelupDialog(
                    level: viewModel.character.level,
                    name: viewModel.character.nickname ?? '',
                    isStageUpgrade: true,
                    stage: viewModel.character.currentStage,
                    species: viewModel.character.species,
                  ));
        },
      );
    });

    // 캐릭터 불러오기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GrowViewModel>().fetchData();
    });

    // 미션 인증 결과 확인하기
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkMissionResult(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _uiEventSubscription?.cancel();
  }

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
    // if (growController.isLoading) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     growController.fetchData().onError((error, stackTrace) {
    //       context.read<AuthController>().logout();
    //       showPlatformDialog(
    //         context: context,
    //         builder: (context) => BasicDialogAlert(
    //           title: const Text("로그인 실패"),
    //           content: const Text('다시 로그인 해주세요'),
    //           actions: <Widget>[
    //             BasicDialogAction(
    //               title: const Text("확인"),
    //               onPressed: () {
    //                 Navigator.pop(context);
    //                 Navigator.of(context)
    //                     .pushReplacementNamed(AuthScreen.routeName);
    //               },
    //             ),
    //           ],
    //         ),
    //       );
    //     });
    //   });
    // }

    return growController.isLoading
        ? const Center(
            child: PlatformBasedLoadingIndicator(),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 레벨 위젯
              const LevelWidget(),
              const SizedBox(height: 24),
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: const [
                    // 레벨업 시 레벨업 효과
                    Positioned(top: -100, child: StageUpEffect()),
                    // 캐릭터 이미지
                    CharacterImageWidget(),
                    // 하트 버튼을 누르면 하트 표시
                    Positioned(top: -100, child: HeartEffect()),

                    // 물고기 이펙트
                    FishEffect(),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // 성장일기
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const GrowHistoryScreen()));
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/grow_history_icon.png',
                              width: 35,
                              height: 35,
                            ),
                            const SizedBox(height: 7),
                            const Text(
                              '성장 일기',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff505459)),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(width: 40),

                      // 추억 저장소
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const MemorialScreen()));
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/photo_frame_icon.png',
                              width: 38,
                              height: 38,
                            ),
                            const SizedBox(height: 7),
                            const Text(
                              '추억 저장소',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff505459)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  // 먹이 주기
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: FeedButton(
                      onClick: !growController.canFeed
                          ? null
                          : () async {
                              await growController.feed().then((_) {
                                growController.animateFeed();
                                context
                                    .read<AuthController>()
                                    .setGoodsQuantity();
                              });
                            },
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // 놀아 주기
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: PlayButton(
                      remainingSeconds: growController.remainedPlayTime,
                      onClick: () {
                        growController.animatePlay();
                        growController.playWithCharacter();
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ],
          );
  }
}
