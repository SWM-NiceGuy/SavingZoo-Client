import 'package:amond/data/repository/mission_repository_impl.dart';
import 'package:amond/domain/models/mission_list.dart';
import 'package:amond/presentation/controllers/mission_detail_controller.dart';
import 'package:amond/presentation/screens/mission/mission_detail_screen.dart';
import 'package:amond/ui/colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MissionCard extends StatelessWidget {
  const MissionCard({
    required this.mission,
    Key? key,
  }) : super(key: key);

  final MissionList mission;

  @override
  build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return GestureDetector(
      // 미션카드 터치시 미션 상세 페이지로 이동
      onTap: () {
        // FA 로그
        FirebaseAnalytics.instance.logEvent(name: '미션카드_터치', parameters: {
          '미션id': mission.id,
          '미션이름': mission.name,
          '상태': mission.state
        });
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 미션 아이콘 (아마 사진이 될 것)
                  mission.iconUrl == ""
                      ? const Icon(
                          Icons.water_drop,
                          size: 48,
                          color: Colors.blue,
                        )
                      : Image.network(
                          mission.iconUrl,
                          height: 40,
                          fit: BoxFit.cover,
                          loadingBuilder: (_, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Image.asset(
                              'assets/images/img_placeholder.gif',
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                  const SizedBox(width: 24),
                  SizedBox(
                    width: deviceSize.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // 미션 내용 및 경험치
                      children: [
                        Text(
                          mission.name,
                          style: const TextStyle(
                              fontSize: 20, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // 미션 성공 여부
                  if (mission.state == 'WAIT')
                    Image.asset("assets/images/grey_check_icon.png",
                        width: 40, height: 40),
                  if (mission.state == 'COMPLETED')
                    Image.asset("assets/images/check_icon.png",
                        width: 40, height: 40),
                ],
              ),
            ],
          )),
    );
  }
}
