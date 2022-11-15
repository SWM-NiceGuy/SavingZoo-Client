import 'package:amond/data/repository/character_repository_impl.dart';
import 'package:amond/presentation/controllers/grow_history_view_model.dart';
import 'package:amond/presentation/screens/grow/components/grow_info_row.dart';
import 'package:amond/presentation/widget/platform_based_indicator.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GrowHistoryScreen extends StatelessWidget {
  const GrowHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          GrowHistoryViewModel(context.read<CharacterRepositoryImpl>()),
      child: const GrowHistoryWidget(),
    );
  }
}

class GrowHistoryWidget extends StatelessWidget {
  const GrowHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final viewModel = context.watch<GrowHistoryViewModel>();

    if (viewModel.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel.fetchData();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('성장 일기'),
      ),
      body: Center(
        child: viewModel.isLoading
            ? const PlatformBasedLoadingIndicator()
            : Column(
                children: [
                  Text(
                    viewModel.currentIdxStage.description ??
                        '${viewModel.history.petName}이(가) 자연으로 무사히 돌아갈 수 있도록\n잘 돌봐주세요!',
                    style: const TextStyle(
                      fontSize: 14,
                      color: greyColor,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  // 캐릭터 모델
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                          width: deviceSize.width * 0.9,
                          height: deviceSize.height * 0.4,
                          child: Center(
                            child: viewModel.currentIdxStage.growState
                                // ? Image.asset(
                                //     'assets/characters/${viewModel.history.species}/normal/${viewModel.index + 1}.png',
                                //     width: deviceSize.width * 0.6,
                                //   )
                                ? Image.asset(
                                    'assets/characters/${viewModel.history.species}/normal/${viewModel.index + 1}.png',
                                    width: deviceSize.width * 0.6,
                                  )
                                : Image.asset(
                                    'assets/characters/${viewModel.history.species}/silhouettes/${viewModel.index + 1}.png',
                                    width: deviceSize.width * 0.4,
                                  ),
                          )),
                      // 캐릭터 왼쪽 화살표
                      Positioned(
                          left: 0,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              viewModel.changeIndex(forward: false);
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: const [
                                SizedBox(width: 40, height: 40),
                                Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Color(0xffa0a0a0),
                                ),
                              ],
                            ),
                          )),

                      // 캐릭터 오른쪽 화살표
                      Positioned(
                        right: 0,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            viewModel.changeIndex();
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: const [
                              SizedBox(width: 40, height: 40),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xffa0a0a0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // 정보 하단 컨테이너
                  Container(
                    width: double.infinity,
                    height: deviceSize.height * 0.4,
                    padding: const EdgeInsets.symmetric(vertical: 20),

                    // 컨테이너 decoration
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff9C9C9C).withOpacity(0.25),
                          offset: const Offset(0, -3),
                          blurRadius: 30,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(37),
                          topRight: Radius.circular(37)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 이름
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 이름
                            Text(viewModel.history.petName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            const SizedBox(width: 8),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // 레벨
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: textBlueColor300,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                  text: viewModel
                                      .history.stages[viewModel.index].level
                                      .toString(),
                                  style: const TextStyle(fontSize: 36)),
                              const TextSpan(text: 'Level')
                            ],
                          ),
                        ),

                        // 캐릭터 정보 (몸무게, 키 등등)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 40, top: 5),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GrowInfoRow(
                                    title: '몸무게',
                                    value: viewModel.currentIdxStage.growState
                                        ? viewModel.currentIdxStage.weight
                                        : '???',
                                  ),
                                  const SizedBox(height: 12),
                                  GrowInfoRow(
                                    title: '키',
                                    value: viewModel.currentIdxStage.growState
                                        ? viewModel.currentIdxStage.height
                                        : '???',
                                  ),
                                  const SizedBox(height: 12),
                                  GrowInfoRow(
                                    title: '생일',
                                    value:
                                        '${viewModel.history.birth.year}년 ${viewModel.history.birth.month}월 ${viewModel.history.birth.day}일',
                                  ),
                                  const SizedBox(height: 12),
                                  if (viewModel.currentIdxStage.stage > 1)
                                    GrowInfoRow(
                                      title: '성장한 날짜',
                                      value: viewModel.currentIdxStage.growState
                                          ? '${viewModel.currentIdxStage.grownDate?.year}년 ${viewModel.currentIdxStage.grownDate?.month}월 ${viewModel.currentIdxStage.grownDate?.day}일'
                                          : '???',
                                    ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
