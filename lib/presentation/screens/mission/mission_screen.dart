import 'package:amond/data/repository/mission_repository_impl.dart';
import 'package:amond/presentation/screens/widget/banner_slider.dart';
import 'package:provider/provider.dart';
import 'package:amond/presentation/controllers/mission_controller.dart';
import 'package:flutter/material.dart';

import 'components/mission_card.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({Key? key}) : super(key: key);

  static const String routeName = "/mission";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          MissionController(context.read<MissionRepositoryImpl>()),
      child: const MissionScreenWidget(),
    );
  }
}

class MissionScreenWidget extends StatelessWidget {
  const MissionScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final missionController = context.watch<MissionController>();

    if (missionController.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        missionController.fetchMissions();
      });
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20, vertical:10),
          child: BannerSlider(),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            itemCount: missionController.missions.length,
            itemBuilder: (context, index) => Container(
              // 카드 간의 상하 간격
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: MissionCard(
                mission: missionController.missions[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
