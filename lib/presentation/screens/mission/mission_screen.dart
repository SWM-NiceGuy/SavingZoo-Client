import 'dart:async';

import 'package:amond/data/repository/mission_repository_impl.dart';
import 'package:amond/domain/models/mission_list.dart';
import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/screens/mission/util/check_mission_result.dart';

import 'package:amond/presentation/screens/mission/util/time_util.dart';
import 'package:amond/presentation/widget/banner/banner_slider.dart';
import 'package:amond/ui/colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';
import 'package:amond/presentation/controllers/mission_view_model.dart';
import 'package:flutter/material.dart';

import '../../controllers/mission_detail_view_model.dart';
import 'components/mission_card.dart';
import 'mission_detail_screen.dart';

class MissionScreen extends StatefulWidget {
  const MissionScreen({Key? key}) : super(key: key);

  static const String routeName = "/mission";

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  @override
  void initState() {
    super.initState();

    // 미션 불러오기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<MissionViewModel>();
      viewModel.fetchMissions(categoryName: viewModel.selectedCategory);
    });

    // 미션 인증 결과 확인하기
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkMissionResult(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MissionViewModel>();

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          Container(
            color: kMissionScreenAppBarColor,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 32.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: _GreetingText(),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: _MissionTimer(),
                ),
                SizedBox(height: 48.0),
              ],
            ),
          ),
          // 배너
          const Padding(
            padding: EdgeInsets.only(left: 12, right: 12, top: 12),
            child: BannerSlider(),
          ),
          // 카테고리
          _CategorySection(
            categories: viewModel.categories,
            selectedCategory: viewModel.selectedCategory,
            onCategoryClick: (name) =>
                viewModel.fetchMissions(categoryName: name),
          ),
          _MissionSection(
            headerTitle: '세상쉬운 환경보호',
            missions: viewModel.basicMissions,
          ),
          _MissionSection(
            headerTitle: '지구를 위한 작은 움직임',
            missions: viewModel.intermediateMissions,
          ),
          _MissionSection(
            headerTitle: '이정도면 나도 환경보호 전문가',
            missions: viewModel.advancedMissions,
          ),
        ],
      ),
    );
  }
}

class _GreetingText extends StatelessWidget {
  const _GreetingText({
    Key? key,
  }) : super(key: key);

  final textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 27.0,
    fontWeight: FontWeight.w300,
  );

  @override
  Widget build(BuildContext context) {
    final String name =
        context.select<AuthController, String>((value) => value.userName);
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$name님,\n',
            style: textStyle.copyWith(fontWeight: FontWeight.w700),
          ),
          TextSpan(text: '오늘도 미션 수행하면서\n겸사겸사', style: textStyle),
          TextSpan(
            text: ' 환경보호',
            style: textStyle.copyWith(fontWeight: FontWeight.w700),
          ),
          TextSpan(text: ' 해보세요!', style: textStyle),
        ],
      ),
    );
  }
}

class _MissionTimer extends StatefulWidget {
  const _MissionTimer({
    Key? key,
  }) : super(key: key);

  @override
  State<_MissionTimer> createState() => _MissionTimerState();
}

class _MissionTimerState extends State<_MissionTimer> {
  late int _seconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    var tomorrowNoon = DateTime(now.year, now.month, now.day + 1);
    _seconds = tomorrowNoon.difference(now).inSeconds;
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_seconds == 1) {
          setState(() {
            timer.cancel();
            _seconds--;
          });
        } else {
          setState(() {
            _seconds--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 119,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white.withOpacity(0.5),
      ),
      child: Center(
        child: Text(
          '${secondsToTimeLeft(_seconds)} 남음',
          style: const TextStyle(fontSize: 12.0, color: Color(0xFF7EA6E1)),
        ),
      ),
    );
  }
}

class _MissionHeader extends StatelessWidget {
  final String headerTitle;
  final int rewardCount;

  const _MissionHeader({
    required this.headerTitle,
    required this.rewardCount,
    Key? key,
  }) : super(key: key);

  final headerTextStyle = const TextStyle(
    fontSize: 16.0,
    color: Color(0xFF6F98D7),
    fontWeight: FontWeight.w600,
  );

  final bodyTextStyle = const TextStyle(
    fontSize: 14.0,
    color: Color(0xFF6F98D7),
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(headerTitle, style: headerTextStyle),
        Row(
          children: [
            Image.asset('assets/images/fish_icon.png', height: 20.0),
            const SizedBox(width: 8.0),
            Text('X', style: bodyTextStyle),
            const SizedBox(width: 8.0),
            Text(rewardCount.toString(), style: bodyTextStyle),
          ],
        )
      ],
    );
  }
}

class _MissionSection extends StatelessWidget {
  final String headerTitle;
  final List<MissionList> missions;

  const _MissionSection({
    required this.headerTitle,
    required this.missions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (missions.isEmpty) {
      return Container();
    }

    return Column(
      children: [
        const SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: _MissionHeader(
            headerTitle: headerTitle,
            rewardCount: missions.first.reward,
          ),
        ),
        const SizedBox(height: 20.0),
        ...missions.map(
          (mission) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: MissionCard(
                mission: mission,
                onClick: () => goToMissionDetail(context, mission),
              ),
            );
          },
        ),
        const SizedBox(height: 30.0),
        const Divider(
          height: 1.0,
          color: Color(0xFFD1E3FF),
        ),
      ],
    );
  }

  void goToMissionDetail(BuildContext context, MissionList mission) {
    // FA 로그
    FirebaseAnalytics.instance.logEvent(
      name: '미션카드_터치',
      parameters: {
        '미션id': mission.id,
        '미션이름': mission.name,
        '상태': mission.state.toString(),
      },
    );

    Navigator.of(context)
        .push(
      MaterialPageRoute(
        // MissionDetailController를 여기서 주입
        builder: (context) => ChangeNotifierProvider<MissionDetailViewModel>(
          create: (_) => MissionDetailViewModel(
            context.read<MissionRepositoryImpl>(),
            missionId: mission.id,
          ),
          child: const MissionDetailScreen(),
        ),
      ),
    )
        .then((_) {
      // 상태가 변경된 미션이 있을 수 있으니 미션을 다시 불러온다
      final viewModel = context.read<MissionViewModel>();
      viewModel.fetchMissions(categoryName: viewModel.selectedCategory);
      checkMissionResult(context);
    });
  }
}

class _CategorySection extends StatelessWidget {
  final void Function(String name) onCategoryClick;
  final List<String> categories;
  final String selectedCategory;

  const _CategorySection({
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryClick,
    Key? key,
  }) : super(key: key);

  Widget buildButton(String text) {
    final isSelected = text == selectedCategory;

    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor:
              isSelected ? kMissionScreenAppBarColor : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20.0)),
      onPressed: () => onCategoryClick(text),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : kBlue,
          fontSize: 15.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12.0,
        children: categories.map((label) => buildButton(label)).toList(),
      ),
    );
  }
}
