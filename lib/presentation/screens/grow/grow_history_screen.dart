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
  final GrowHistory history = GrowHistory(petName: '냐옹이', birth: DateTime.fromMillisecondsSinceEpoch(1666939721000), stages: [
    GrowStage(
        level: 1,
        growState: true,
        weight: '3kg',
        height: '4cm',
        grownDate: DateTime.fromMillisecondsSinceEpoch(1667269570000)
        ),
    GrowStage(
        level: 15,
        growState: true,
        weight: '5kg',
        height: '7cm',
        grownDate: DateTime.fromMillisecondsSinceEpoch(1669269570000)
    ),
    GrowStage(
        level: 30,
        growState: false,
        weight: '7kg',
        height: '10cm',
        grownDate: DateTime.fromMillisecondsSinceEpoch(1672269570000)
    ),
  ]);

  var _growStageIndex = 0;
  var _test = false;

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
                    src: _test ? 'assets/glb/Shiba.glb' : 'assets/glb/cat.glb',
                    cameraControls: true,
                    loading: Loading.auto,
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
                          _test = !_test;
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
                        _test = !_test;
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
                                fontSize: 20, fontWeight: FontWeight.w500)),
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
                          ),
                        ),
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
                      ),
                    ),

                    // 캐릭터 정보 (몸무게, 키 등등)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50, right: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GrowInfoRow(
                              title: '몸무게',
                              value: history.stages[_growStageIndex].growState ? history.stages[_growStageIndex].weight : '???',
                            ),
                            GrowInfoRow(
                              title: '키',
                              value: history.stages[_growStageIndex].growState ? history.stages[_growStageIndex].height : '???',
                            ),
                            GrowInfoRow(
                              title: '생일',
                              value: '${history.birth.year}년 ${history.birth.month}월 ${history.birth.day}일',
                            ),
                            GrowInfoRow(
                              title: '함께한지',
                              value: history.stages[_growStageIndex].growState ? history.growDifference(_growStageIndex) : '???',
                            )
                          ],
                        ),
                      ),
                    )
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

class GrowInfoRow extends StatelessWidget {
  const GrowInfoRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        Container(
          alignment: Alignment.centerLeft,
          width: 200,
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: kMissionScreenBgColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: textBlueColor200,
            ),
          ),
        )
      ],
    );
  }
}
