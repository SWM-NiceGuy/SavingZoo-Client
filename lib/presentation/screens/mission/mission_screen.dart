import 'package:amond/data/entity/mission_entity.dart';
import 'package:amond/presentation/controllers/mission_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/mission_card.dart';

class MissionScreen extends StatelessWidget {
  MissionScreen({Key? key}) : super(key: key);

  static const String routeName = "/mission";

  bool isDataFetched = false;

  var missions = [
    MissionEntity(id: 1, title: 'test1', content: '테스트1', imageUrl: '', reward: 1, state: 'COMPLETE'),
    MissionEntity(id: 2, title: 'test2', content: '테스트1', imageUrl: '', reward: 1, state: 'COMPLETE'),
    MissionEntity(id: 3, title: 'test3', content: '테스트1', imageUrl: '', reward: 1, state: 'COMPLETE'),
    MissionEntity(id: 4, title: 'test4', content: '테스트1', imageUrl: '', reward: 1, state: 'COMPLETE'),
  ];

  @override
  Widget build(BuildContext context) {
    // final missionController = context.watch<MissionController>();

    // if (!isDataFetched) {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     isDataFetched = true;
    //     missionController.fetchMissions();
    //   });
    // }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      itemCount: missions.length,
      itemBuilder: (context, index) => Container(
        // 카드 간의 상하 간격
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: MissionCard(
          mission: missions[index],
        ),
      ),
    );
  }
}
