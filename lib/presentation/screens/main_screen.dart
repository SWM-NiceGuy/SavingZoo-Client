import 'package:amond/data/repository/mission_repository_impl.dart';
import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/controllers/grow_view_model.dart';
import 'package:amond/presentation/controllers/mission_history_view_model.dart';
import 'package:amond/presentation/screens/mission/mission_history_screen.dart';
import 'package:amond/presentation/screens/mission/mission_screen.dart';
import 'package:amond/presentation/screens/settings/settings_screen.dart';
import 'package:amond/utils/dialogs/dialogs.dart';
import 'package:amond/utils/push_notification.dart';
import 'package:amond/utils/version/app_version.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:amond/presentation/screens/grow/grow_screen.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String routeName = '/main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> bottomNavigationBarScreens = [
    const MissionScreen(),
    const GrowScreen(),
  ];

  var _screenIndex = 0;

  late List<String> appBarTitle = ["", ""];

  List<Color> appBarColors = [
    kMissionScreenAppBarColor,
    Colors.white,
  ];

  List<Color> backgroundColors = [
    kMissionScreenBgColor,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 앱 업데이트가 있으면 다이얼로그를 통해 알려줌.
      if (!currentAppStatus!.isLatest()) {
        showUpdateDialog(context);
      }

      final growViewModel = context.read<GrowViewModel>();
      growViewModel.fetchData().then((_) {
        setState(() {
          appBarTitle[1] = growViewModel.character.nickname ?? "";
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 처음 접속하는 유저들에게 푸시 알림 설정을 받음.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showPushNotificationPermissionDialog(context);
    });

    final authController = context.read<AuthController>();
    return Scaffold(
      drawer: mainDrawer(context, authController),
      appBar: AppBar(
        title: Text(appBarTitle[_screenIndex]),
        foregroundColor: Colors.black,
        elevation: 0.0,
        backgroundColor: appBarColors[_screenIndex],
        iconTheme: const IconThemeData(color: Color(0xFF6A6A6A)),
      ),
      backgroundColor: backgroundColors[_screenIndex],
      body: SafeArea(
        child: bottomNavigationBarScreens[_screenIndex],
      ),
      extendBody: true,
      bottomNavigationBar: _BottomNavigationBar(
        screenIndex: _screenIndex,
        onTap: (index) {
          setState(() => _screenIndex = index);
        },
      ),
    );
  }

  Drawer mainDrawer(BuildContext context, AuthController authController) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 미션수행 기록
            ListTile(
              leading: const Icon(
                Icons.history,
                color: blackColor,
              ),
              title: const Text('미션수행 기록'),
              onTap: () {
                // FA 로그
                FirebaseAnalytics.instance.logEvent(name: '미션내역_조회');
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => MissionHistoryViewModel(
                      context.read<MissionRepositoryImpl>(),
                    ),
                    child: const MissionHistoryScreen(),
                  ),
                ));
              },
            ),
            // 설정
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: blackColor,
              ),
              title: const Text('설정'),
              onTap: () {
                Navigator.of(context).pushNamed(SettingsScreen.routeName);
              },
            ),
            // 개발자에 문의하기
            ListTile(
              leading: const Icon(
                Icons.question_answer_rounded,
                color: blackColor,
              ),
              title: const Text('의견 보내기'),
              onTap: () async {
                final url = Uri.parse('https://pf.kakao.com/_JLxkxob/chat');
                if (await canLaunchUrl(url)) {
                  launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final int screenIndex;
  final Function(int index) onTap;

  const _BottomNavigationBar({
    required this.screenIndex,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: kBlack,
        items: [
          BottomNavigationBarItem(
            label: '홈',
            icon: Image.asset(
              'assets/images/home_icon_normal.png',
              width: 32,
              height: 32,
            ),
            activeIcon: Image.asset(
              'assets/images/home_icon_pressed.png',
              width: 32,
              height: 32,
            ),
          ),
          BottomNavigationBarItem(
            label: '보호소',
            icon: Image.asset(
              'assets/images/pets_icon_normal.png',
              width: 32,
              height: 32,
            ),
            activeIcon: Image.asset(
              'assets/images/pets_icon_pressed.png',
              width: 32,
              height: 32,
            ),
          )
        ],
        onTap: onTap,
        currentIndex: screenIndex,
      ),
    );
  }
}
