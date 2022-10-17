import 'package:amond/data/repository/mission_repository_impl.dart';
import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/controllers/mission_history_controller.dart';
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
    const GrowScreen(),
    const MissionScreen(),
  ];

  List<Widget> appBarTitle = [
    const Text(""),
    const Text("미션"),
  ];

  var _screenIndex = 0;

  @override
  void initState() {
    super.initState();

    // 앱 업데이트가 있으면 다이얼로그를 통해 알려줌.
    if (!currentAppStatus!.isLatest()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showUpdateDialog(context);
      });
    }
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
        title: appBarTitle[_screenIndex],
        foregroundColor: Colors.black,
        elevation: 0.0,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: Color(0xFF96CE5F)),
      ),
      body: SafeArea(
        child: bottomNavigationBarScreens[_screenIndex],
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.white, offset: Offset(-5, -5), blurRadius: 9)
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            backgroundColor: backgroundColor,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                label: '홈',
                icon: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Color(0xffA6B4C8),
                        offset: Offset(3, 5),
                        blurRadius: 7)
                  ], shape: BoxShape.circle),
                  child: Image.asset('assets/images/home_normal.png',
                      width: 40, height: 40),
                ),
                activeIcon: Image.asset(
                  'assets/images/home_pressed.png',
                  width: 40,
                  height: 40,
                ),
              ),
              BottomNavigationBarItem(
                label: '미션',
                icon: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Color(0xffA6B4C8),
                        offset: Offset(3, 5),
                        blurRadius: 7)
                  ], shape: BoxShape.circle),
                  child: Image.asset(
                    'assets/images/mission_normal.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                activeIcon: Image.asset(
                  'assets/images/mission_pressed.png',
                  width: 40,
                  height: 40,
                ),
              )
            ],
            onTap: (index) {
              setState(() {
                _screenIndex = index;
              });
            },
            currentIndex: _screenIndex,
          ),
        ),
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
                    create: (context) => MissionHistoryController(
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
                if (await canLaunchUrl(
                    Uri.parse('https://pf.kakao.com/_JLxkxob/chat'))) {
                  launchUrl(Uri.parse('https://pf.kakao.com/_JLxkxob/chat'),
                      mode: LaunchMode.externalApplication);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
