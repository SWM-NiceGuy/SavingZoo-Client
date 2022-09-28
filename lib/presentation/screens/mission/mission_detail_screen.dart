import 'package:amond/presentation/screens/mission/components/mission_detail_bottom_bar.dart';
import 'package:amond/presentation/screens/mission/components/mission_example.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
                const Text("미션",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                // 미션 내용
                Text("금속캔 세척하고 압착하여 배출하기", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 24),
                // 미션 이유
                // GestureDetector(
                //     onTap: () {},
                //     child: const Text("왜 이렇게 해야 하나요?",
                //         style: TextStyle(decoration: TextDecoration.underline))),
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
