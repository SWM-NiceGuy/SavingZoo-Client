import 'package:amond/data/entity/mission_entity.dart';
import 'package:amond/data/repository/mission_repository_impl.dart';
import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/controllers/mission_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/mission_card.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({Key? key}) : super(key: key);

  static const String routeName = "/mission";

  @override
  Widget build(BuildContext context) {
    // MissionController를 여기서 주입한다.
    return ChangeNotifierProxyProvider<AuthController, MissionController>(
      create: (context) => MissionController(context.read<MissionRepositoryImpl>(), member: context.read<AuthController>().memberInfo!),
    update: (context, authController, previous) => MissionController(context.read<MissionRepositoryImpl>(), member: authController.memberInfo!),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        itemCount: 3,
        itemBuilder: (context, index) => Container(
          // 카드 간의 상하 간격
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: MissionCard(
            mission: MissionEntity(
              id: 1,
              title: "플로깅",
              content: "어떤 공원이든 상관 없습니다! 공원을 걸으시면서 겸사겸사 쓰레기를 주워봐요!",
              reward: 8,
              state: "WAIT",
              imageUrl: "",
            ),
          ),
        ),
      ),
    );
  }
}

