import 'package:amond/presentation/screens/mission/components/mission_detail_bottom_bar.dart';
import 'package:amond/presentation/screens/mission/components/mission_example.dart';
import 'package:flutter/material.dart';

class MissionDetailScreen extends StatelessWidget {
  const MissionDetailScreen({Key? key}) : super(key: key);

  static const String routeName = '/mission-detail';

  @override
  Widget build(BuildContext context) {
    // 미션 id
    final id = ModalRoute.of(context)?.settings.arguments as int?;
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // 미션 이름
        title: Text('금속캔'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      // 미션 인증 하단 바
      bottomNavigationBar: MissionDetailBottomBar(),
      body: ListView(
        children: [
          // 미션 인증예시 사진1
          Image.network(
            'https://metacode.biz/@test/avatar.jpg',
            height: deviceSize.height * 0.4,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 미션이유
                Text(
                    "배달 음식의 편리함은 포기하기가 어려워요🥲 대신 음식이 담겼던 플라스틱 용기를 깨끗하게 세척하여 환경 보호 해봐요!"),
                const SizedBox(height: 24),
                const Text("미션",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                // 미션 내용
                Text("금속캔 세척하고 압착하여 배출하기", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 24),
                const Text("미션 인증 방법",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                // 미션 인증 방법
                Text("음식이 담겼던 플라스틱 용기를 깨끗히 세척 후 사진을 찍어 인증해주세요"),
                const SizedBox(height: 48),
                const Text(
                  "미션 인증 예시",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  3,
                  (index) => const MissionExample(
                      imageUrl: 'https://metacode.biz/@test/avatar.jpg')),
            ),
          )
        ],
      ),
    );
  }
}
