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
        child: MissionCard(),
      ),
    );
  }
}

