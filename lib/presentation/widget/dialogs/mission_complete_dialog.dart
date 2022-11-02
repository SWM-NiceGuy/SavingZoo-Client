import 'package:amond/domain/models/mission_result.dart';
import 'package:amond/presentation/widget/main_button.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class MissionCompleteDialog extends StatelessWidget {
  const MissionCompleteDialog({
    required this.result,
    Key? key,
    required this.onPop,
  }) : super(key: key);

  final MissionResult result;
  final Function onPop;

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {return false;},
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(26.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    '미션 수행 결과',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  const _Divider(),
                  const SizedBox(height: 22),
    
                  const _ResultRow(
                      child1: Text(
                        '성공',
                        style: TextStyle(fontSize: 18, color: textBlueColor200),
                      ),
                      child2: Text(
                        '보상',
                        style: TextStyle(fontSize: 18, color: Color(0xff919191)),
                      )),
    
                  const SizedBox(height: 22),
    
                  // 성공한 미션들
                  ..._completedMission(),
    
                  const SizedBox(height: 28),
                  const _Divider(),
                  const SizedBox(height: 22),
    
                  const _ResultRow(
                      child1: Text(
                        '반려',
                        style: TextStyle(fontSize: 18, color: textBlueColor200),
                      ),
                      child2: Text(
                        '사유',
                        style: TextStyle(fontSize: 18, color: Color(0xff919191)),
                      )),
    
                  const SizedBox(height: 22),
    
                  // 실패한 미션들
                  ..._rejectedMission(),
                ],
              ),
            ),
            const _Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Text('   총 ',
                        style: TextStyle(fontSize: 18, color: blackColor)),
                    Image.asset('assets/images/fish_icon.png',
                        width: 25, height: 25),
                    Text(' ${result.totalReward} 획득',
                        style: const TextStyle(fontSize: 18, color: blackColor)),
                  ],
                ),
                MainButton(
                  onPressed: () {
                    onPop.call();
                    Navigator.of(context).pop();
                  },
                  height: 56,
                  width: 149,
                  child: const Text('받기'),
                )
              ],
            ),
            const SizedBox(height: 13),
          ],
        ),
      ),
    );
  }

  List<Widget> _completedMission() {
    return List.generate(result.completedMission.length, (index) {
      final currentElem = result.completedMission[index];
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _ResultRow(
            // 미션 이름
            child1: Text(
              currentElem.missionTitle,
              style: const TextStyle(fontSize: 16, color: darkGreyColor),
            ),

            // 보상
            child2: Row(
              children: [
                Image.asset(
                  'assets/images/fish_icon.png',
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 7),
                Text(
                  currentElem.reward.toString(),
                  style: const TextStyle(color: textBlueColor200),
                ),
              ],
            ),
          ),

          // 아래쪽 마진
          if (index != result.completedMission.length - 1)
            const SizedBox(height: 8),
        ],
      );
    });
  }

  List<Widget> _rejectedMission() {
    return List.generate(result.rejectedMission.length, (index) {
      final currentElem = result.rejectedMission[index];
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _ResultRow(
            // 미션 이름
            child1: Text(
              currentElem.missionTitle,
              style: const TextStyle(fontSize: 16, color: darkGreyColor),
            ),

            // 반려 사유
            child2: Text(
              currentElem.reason,
              style: const TextStyle(fontSize: 16, color: Color(0xff818181)),
            ),
          ),

          // 아래쪽 마진
          if (index != result.completedMission.length - 1)
            const SizedBox(height: 8),
        ],
      );
    });
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({Key? key, required this.child1, required this.child2})
      : super(key: key);

  final Widget child1;
  final Widget child2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [child1, child2],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffE3E3E3)),
      ),
      height: 1,
    );
  }
}
