import 'package:amond/domain/models/mission_history.dart';
import 'package:amond/domain/models/mission_state.dart';
import 'package:amond/presentation/screens/mission/util/get_history_text_by_state.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key? key,
    required this.history,
  }) : super(key: key);

  final MissionHistory history;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 78,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 수행 시간
                Text('${history.date.month}.${history.date.day}', style: TextStyle(color: Color(0xff939393)),),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 기록 내용
                    Text(history.missionName, style: TextStyle(color: darkGreyColor, fontSize: 18,),),

                    // 반려 시 사유
                    if (history.state == MissionState.rejected)
                    Text('사유사유', style: TextStyle(fontSize: 14, color: Color(0xff939393),),)
                  ],
                ),
                const Spacer(),


                // 미션 상태

                // 성공
                if (history.state == MissionState.completed)
                Column(
                  children: [
                    const Text('성공', style: TextStyle(fontSize: 14, color: textBlueColor200),),
                    Row(
                      children: [
                        Image.asset('assets/images/fish_icon.png', height: 13, width: 13,),
                        const SizedBox(width: 4),
                        Text(history.reward.toString(), style: const TextStyle(color: darkGreyColor, fontSize: 14),)
                      ],
                    ),
                  ],
                )
                // 대기
                else if (history.state == MissionState.wait)
                const Text('인증 대기중', style: TextStyle(color: greyColor, fontSize: 14),)

                // 반려
                else if (history.state == MissionState.rejected)
                const Text('반려', style: TextStyle(color: greyColor, fontSize: 14),)
              ],
            ),
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: const Color(0xffeff4fd),
        )
      ],
    );
  }
}