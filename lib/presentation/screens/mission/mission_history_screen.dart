import 'package:amond/domain/models/mission_history.dart';
import 'package:amond/domain/models/mission_state.dart';
import 'package:amond/presentation/screens/mission/components/mission_history_card.dart';
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
        itemBuilder: (context, index) => HistoryCard(history: histories[index]),
      ),
    );
  }
}


