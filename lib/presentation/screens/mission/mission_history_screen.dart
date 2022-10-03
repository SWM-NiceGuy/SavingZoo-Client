import 'package:amond/domain/models/mission_history.dart';
import 'package:amond/domain/models/mission_state.dart';
import 'package:amond/presentation/screens/mission/util/get_history_text_by_state.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class MissionHistoryScreen extends StatelessWidget {
  MissionHistoryScreen({Key? key}) : super(key: key);

  static const String routeName = '/mission-history';

  List<MissionHistory> histories = [
    MissionHistory(state: MissionState.accepted, date: DateTime(2022, 10, 1), type: '미션 수행', missionName: '걷기', reward: 10),
        MissionHistory(state: MissionState.wait, date: DateTime(2022, 9, 29), type: '미션 수행', missionName: '걷기', reward: 10),
            MissionHistory(state: MissionState.rejected, date: DateTime(2022, 9, 29), type: '미션 수행', missionName: '걷기', reward: 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('미션수행 기록'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: blackColor,
        shape: const Border(bottom: BorderSide(color: Color(0xffd7d7d7))),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  // 수행 시간
                  Text('${histories[index].date.month}.${histories[index].date.day}'),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 기록 내용
                      Text('${histories[index].type}${histories[index].missionName}'),
                      // 성공 여부
                      getHistoryTextByState(histories[index].state) 
                    ],
                  ),
                  const Spacer(),
                  // 보상
                  if (histories[index].state == MissionState.accepted)
                  Text('+ ${histories[index].reward}XP',
                      style: const TextStyle(
                          fontSize: 18,
                          color: successColor,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xffd7d7d7),
            )
          ],
        ),
      ),
    );
  }
}
