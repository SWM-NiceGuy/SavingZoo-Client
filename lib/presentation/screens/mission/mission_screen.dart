import 'package:provider/provider.dart';
import 'package:amond/presentation/controllers/mission_controller.dart';
import 'package:flutter/material.dart';

import 'components/mission_card.dart';

class MissionScreen extends StatelessWidget {
  MissionScreen({Key? key}) : super(key: key);

  static const String routeName = "/mission";

  bool isDataFetched = false;

  // var missions = [
  //   MissionList(id: 1, name: 'test1', iconUrl: '', state: 'ACCEPTED'),
  //   MissionList(id: 2, name: 'test2', iconUrl: '', state: 'INCOMPLETE'),
  //   MissionList(id: 3, name: 'test3', iconUrl: '', state: 'COMPLETE'),
  //   MissionList(id: 4, name: 'test4', iconUrl: '', state: 'COMPLETE'),
  // ];

  @override
  Widget build(BuildContext context) {
    final missionController = context.watch<MissionController>();

    if (!isDataFetched) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        isDataFetched = true;
        missionController.fetchMissions();
      });
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      itemCount: missionController.missions.length,
      itemBuilder: (context, index) => Container(
        // 카드 간의 상하 간격
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: MissionCard(
          mission: missionController.missions[index],
        ),
      ),
    );
  }
}
