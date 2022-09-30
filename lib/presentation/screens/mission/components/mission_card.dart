import 'package:amond/data/entity/mission_entity.dart';
import 'package:amond/data/repository/mission_repository_impl.dart';
import 'package:amond/presentation/controllers/mission_controller.dart';
import 'package:amond/presentation/controllers/mission_detail_controller.dart';
import 'package:amond/presentation/screens/mission/mission_detail_screen.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mission_complete_dialog.dart';

class MissionCard extends StatelessWidget {
  const MissionCard({
    required this.mission,
    Key? key,
  }) : super(key: key);

  final MissionEntity mission;

  @override
  build(BuildContext context) {
    final missionController = context.read<MissionController>();
    return GestureDetector(
      // 미션카드 터치시 미션 상세 페이지로 이동
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            // MissionDetailController를 여기서 주입
            builder: (context) =>
                ChangeNotifierProvider<MissionDetailController>(
              create: (_) => MissionDetailController(
                  context.read<MissionRepositoryImpl>(),
                  missionId: mission.id),
              child: MissionDetailScreen(),
            ),
          ),
        );
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 6,
                  offset: const Offset(4, 4),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  blurRadius: 6,
                  offset: const Offset(-4, -4),
                )
              ]),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 미션 아이콘 (아마 사진이 될 것)
                  mission.imageUrl == ""
                      ? const Icon(
                          Icons.water_drop,
                          size: 48,
                          color: Colors.blue,
                        )
                      : Image.network(mission.imageUrl,
                          height: 40, fit: BoxFit.cover),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // 미션 내용 및 경험치
                    children: [
                      Text(mission.title,
                          style: const TextStyle(
                              fontSize: 24, overflow: TextOverflow.ellipsis)),
                      Text("+${mission.reward}XP",
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const Spacer(),
                  // 미션 성공 여부
                  if (mission.state == 'COMPLETE')
                    Image.asset("assets/images/check_icon.png"),
                ],
              ),
            ],
          )),
    );
  }
}
