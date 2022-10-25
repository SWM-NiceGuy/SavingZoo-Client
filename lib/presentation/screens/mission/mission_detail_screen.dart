import 'package:amond/presentation/controllers/mission_detail_controller.dart';
import 'package:amond/presentation/screens/mission/components/image_slider.dart';
import 'package:amond/presentation/screens/mission/components/mission_detail_bottom_bar.dart';
import 'package:amond/ui/colors.dart';
import 'package:amond/widget/platform_based_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MissionDetailScreen extends StatelessWidget {
  const MissionDetailScreen({Key? key}) : super(key: key);

  static const String routeName = '/mission-detail';

  @override
  Widget build(BuildContext context) {
    // 미션 id
    final width = MediaQuery.of(context).size.width;

    final viewModel = context.watch<MissionDetailController>();

    if (viewModel.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel.fetchData();
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // 미션 이름
        title: const Text('미션',
            style: TextStyle(color: kBlack, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: const BackButton(color: kBlack),
      ),
      // 미션 인증 하단 바
      bottomNavigationBar: viewModel.isLoading
          ? const SizedBox()
          : MissionDetailBottomBar(mission: viewModel.mission),
      body: viewModel.isLoading
          ? const Center(child: PlatformBasedIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  _Title(text: viewModel.mission.content),
                  const SizedBox(height: 12.0),
                  _Reward(reward: viewModel.mission.reward),
                  const SizedBox(height: 24.0),
                  ImageSlider(
                    images: viewModel.mission.exampleImageUrls
                        .map((url) => Image.network(url, fit: BoxFit.cover))
                        .toList(),
                    width: width * 0.85,
                    height: width * 0.7,
                  ),
                  const SizedBox(height: 24.0),
                  // 미션이유
                  SizedBox(
                    width: width * 0.7,
                    child: Text(
                      viewModel.mission.description,
                      style: const TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: width * 0.85,
                    height: 1.0,
                    child: const Divider(color: kGrey),
                  ),
                  SizedBox(
                    width: width * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset('assets/images/camera_icon.png'),
                            const SizedBox(width: 8.0),
                            const Text(
                              '인증 방법',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: kBlue),
                            )
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Text(viewModel.mission.submitGuide)
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class _Title extends StatelessWidget {
  final String text;
  const _Title({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: kBlue,
        ),
      ),
    );
  }
}

class _Reward extends StatelessWidget {
  final int reward;

  const _Reward({
    required this.reward,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/fish_icon.png', height: 20.0),
        const SizedBox(width: 8.0),
        const Text('X'),
        const SizedBox(width: 8.0),
        Text(reward.toString()),
      ],
    );
  }
}
