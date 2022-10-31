import 'package:amond/domain/models/grow_history.dart';
import 'package:amond/domain/models/grow_stage.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class GrowHistoryScreen extends StatefulWidget {
  const GrowHistoryScreen({Key? key}) : super(key: key);

  @override
  State<GrowHistoryScreen> createState() => _GrowHistoryScreenState();
}

class _GrowHistoryScreenState extends State<GrowHistoryScreen> {
  final GrowHistory history = GrowHistory(petName: '냐옹이', expPct: 60, stages: [
    GrowStage(
        level: 1,
        growState: true,
        weight: 3,
        height: 4,
        birth: DateTime.fromMillisecondsSinceEpoch(1666939721000)),
    GrowStage(
        level: 15,
        growState: true,
        weight: 5,
        height: 7,
        birth: DateTime.fromMillisecondsSinceEpoch(1666939721000)),
    GrowStage(
        level: 30,
        growState: false,
        weight: 7,
        height: 10,
        birth: DateTime.fromMillisecondsSinceEpoch(1666939721000))
  ]);

  var _growStageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('성장 일기'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              '${history.petName} 자연으로 무사히 돌아갈 수 있도록\n잘 돌봐주세요!',
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
                  child: ModelViewer(
                    src: 'assets/glb/cat.glb',
                    cameraControls: true,
                    loading: Loading.lazy,
                  ),
                ),
                // 캐릭터 왼쪽 화살표
                Positioned(
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _growStageIndex == 0
                              ? _growStageIndex = history.stages.length - 1
                              : _growStageIndex -= 1;
                        });
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Color(0xffa0a0a0),
                      ),
                    )),

                // 캐릭터 오른쪽 화살표
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _growStageIndex =
                            (_growStageIndex + 1) % history.stages.length;
                      });
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xffa0a0a0),
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
              child: SafeArea(
                child: Column(
                  children: [
                    // 이름 + 이름 변경 Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 이름
                        Text(history.petName,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 8),
                        // 이름 변경
                        GestureDetector(
                            onTap: () {
                              // 이름 변경 로직
                            },
                            child: const Icon(
                              Icons.edit_outlined,
                              color: Color(0xff8e8e8e),
                              size: 20,
                            ))
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
                            text: history.stages[_growStageIndex].level
                                .toString(),
                            style: const TextStyle(fontSize: 36)),
                        const TextSpan(text: 'Level')
                      ],
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
