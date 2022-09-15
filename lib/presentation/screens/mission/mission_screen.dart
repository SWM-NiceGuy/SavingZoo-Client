import 'package:amond/data/entity/mission_entity.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

import 'components/mission_card.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({Key? key}) : super(key: key);

  static const String routeName = "/mission";

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}

