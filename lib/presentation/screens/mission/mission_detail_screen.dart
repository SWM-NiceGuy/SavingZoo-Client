import 'package:amond/presentation/controllers/mission_detail_controller.dart';
import 'package:amond/presentation/screens/mission/components/mission_detail_bottom_bar.dart';
import 'package:amond/presentation/screens/mission/components/mission_example.dart';
import 'package:amond/presentation/widget/platform_based_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MissionDetailScreen extends StatelessWidget {
  const MissionDetailScreen({Key? key}) : super(key: key);

  static const String routeName = '/mission-detail';

  // MissionDetail mission = MissionDetail(
  //     name: '금속캔',
  //     description:
  //         "배달 음식의 편리함은 포기하기가 어려워요🥲 대신 음식이 담겼던 플라스틱 용기를 깨끗하게 세척하여 환경 보호 해봐요!",
  //     content: '금속캔 세척하고 압착하여 배출하기',
  //     submitGuide: "음식이 담겼던 플라스틱 용기를 깨끗히 세척 후 사진을 찍어 인증해주세요",
  //     exampleImageUrls: [
  //       'https://metacode.biz/@test/avatar.jpg',
  //       'https://metacode.biz/@test/avatar.jpg',
  //       'https://metacode.biz/@test/avatar.jpg',
  //       'https://metacode.biz/@test/avatar.jpg',
  //     ],
  //     reward: 8,
  //     state: 'WAIT');

  @override
  Widget build(BuildContext context) {
    // 미션 id
    final deviceSize = MediaQuery.of(context).size;

    final missionDetailController = context.watch<MissionDetailController>();

    if (missionDetailController.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        missionDetailController.fetchData();
      });
    }

    return Scaffold(
      appBar: AppBar(
        // 미션 이름
        title: Text(missionDetailController.isLoading
            ? ''
            : missionDetailController.mission.name),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      // 미션 인증 하단 바
      bottomNavigationBar: missionDetailController.isLoading
          ? const SizedBox(
              width: 0,
              height: 0,
            )
          : MissionDetailBottomBar(
              reward: missionDetailController.mission.reward),
    
      backgroundColor: Colors.white,
      body: missionDetailController.isLoading
          ? const Center(child: PlatformBasedIndicator())
          : ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                // 미션 인증예시 사진1
                Image.network(
                  missionDetailController.mission.exampleImageUrls.first,
                  height: deviceSize.height * 0.4,
                  fit: BoxFit.fill,
                  loadingBuilder: (_, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return SizedBox(
                      height: deviceSize.height * 0.4,
                      child: const Center(
                        child: PlatformBasedIndicator(),
                      ),
                    );
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 미션이유
                      Text(missionDetailController.mission.description),
                      const SizedBox(height: 36),
                      const Text("미션",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      // 미션 내용
                      Text(missionDetailController.mission.content,
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 36),
                      const Text("인증 방법",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      // 미션 인증 방법
                      Text(missionDetailController.mission.submitGuide),
                      const SizedBox(height: 48),
                      const Text(
                        "미션 인증 예시",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                // 미션 예시 사진
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      missionDetailController.mission.exampleImageUrls.length,
                      (index) => MissionExample(
                          imageUrl: missionDetailController
                              .mission.exampleImageUrls[index]),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
