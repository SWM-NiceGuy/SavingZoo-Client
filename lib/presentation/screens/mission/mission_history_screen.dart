
import 'package:amond/presentation/controllers/mission_history_controller.dart';
import 'package:amond/presentation/screens/mission/components/mission_history_card.dart';
import 'package:amond/ui/colors.dart';
import 'package:amond/widget/platform_based_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MissionHistoryScreen extends StatelessWidget {
  const MissionHistoryScreen({Key? key}) : super(key: key);

  static const String routeName = '/mission-history';

  // List<MissionHistory> histories = [
  //   MissionHistory(
  //       state: MissionState.completed,
  //       date: DateTime(2022, 10, 1),
  //       type: '미션 수행',
  //       missionName: '걷기',
  //       reward: 10),
  //   MissionHistory(
  //       state: MissionState.wait,
  //       date: DateTime(2022, 9, 29),
  //       type: '미션 수행',
  //       missionName: '걷기',
  //       reward: 10),
  //   MissionHistory(
  //       state: MissionState.rejected,
  //       date: DateTime(2022, 9, 29),
  //       type: '미션 수행',
  //       missionName: '걷기',
  //       reward: 10),
  // ];

  @override
  Widget build(BuildContext context) {
    final historyController = context.watch<MissionHistoryController>();

    if (historyController.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        historyController.fetchData();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('미션수행 기록'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: blackColor,
        shape: const Border(bottom: BorderSide(color: Color(0xffd7d7d7))),
      ),
      body: historyController.isLoading
          ? const Center(child: PlatformBasedIndicator())
          : ListView.builder(
              itemCount: historyController.histories.length,
              itemBuilder: (context, index) =>
                  HistoryCard(history: historyController.histories[index]),
            ),
    );
  }
}
