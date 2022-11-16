import 'package:amond/data/repository/mission_repository_impl.dart';
import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/controllers/grow/grow_view_model.dart';
import 'package:amond/presentation/controllers/mission_history_view_model.dart';
import 'package:amond/presentation/screens/auth/auth_screen.dart';
import 'package:amond/presentation/screens/mission/mission_history_screen.dart';
import 'package:amond/presentation/screens/mission/mission_screen.dart';
import 'package:amond/presentation/screens/settings/settings_screen.dart';
import 'package:amond/presentation/screens/store/store_screen.dart';
import 'package:amond/presentation/widget/dialogs/beta_reward_dialog.dart';
import 'package:amond/presentation/widget/dialogs/change_user_name_dialog.dart';
import 'package:amond/presentation/widget/dialogs/dialogs.dart';
import 'package:amond/utils/beta_reward_check.dart';
import 'package:amond/utils/push_notification.dart';
import 'package:amond/utils/version/app_version.dart';
import 'package:amond/utils/version/notice.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:amond/presentation/screens/grow/grow_screen.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String routeName = '/main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> bottomNavigationBarScreens = [
    StoreScreen(),
    const MissionScreen(),
    const GrowScreen(),
  ];

  var _screenIndex = 0;

  late List<String> appBarTitle = ["스토어", "", ""];

  List<Color> appBarColors = [
    kMissionScreenAppBarColor,
    kMissionScreenAppBarColor,
    Colors.white,
  ];

  List<Color> backgroundColors = [
    kMissionScreenBgColor,
    kMissionScreenBgColor,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 앱 업데이트가 있으면 다이얼로그를 보여줌
      if (!currentAppStatus.isLatest) {
        showUpdateDialog(context);
      }

      // 앱 공지사항이 있으면 다이얼로그를 보여줌
      if (appNotice.isApply) {
        showNoticeDialog(context);
      }

      // 기존유저라면 베타유저 보상을 요청한다
      if (!context.read<AuthController>().isNewUser) {
        requestRewardIfNotChecked().then((result) {
          if (result['getReward']) {
            // 보상을 받으면 다이얼로그를 띄운다
            showDialog(
          context: context,
          builder: (_) => BetaRewardDialog(
              reward: result['reward'],
              onPop: () {
                context.read<AuthController>().setGoodsQuantity();
              }));
          }
        });
      }

  

      // 데이터를 불러오는 중에 오류가 발생하면 로그인 실패로 간주
      try {
        final growViewModel = context.read<GrowViewModel>();
        growViewModel.setCharacter().then((_) {
          appBarTitle[2] = growViewModel.character.nickname ?? "";
        });
      } catch (error) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            AuthScreen.routeName, (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 처음 접속하는 유저들에게 푸시 알림 설정을 받음.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showPushNotificationPermissionDialog(context);
    });

    return Scaffold(
      drawer: mainDrawer(context),
      appBar: AppBar(
        title: Center(
            child:
                Text(appBarTitle[_screenIndex], textAlign: TextAlign.center)),
        foregroundColor: Colors.black,
        backgroundColor: appBarColors[_screenIndex],
        iconTheme: const IconThemeData(color: Color(0xFF6A6A6A)),
        actions: const [_GoodsQuantity()],
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

  Drawer mainDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // 이름 탭
            Row(
              children: [
                const SizedBox(width: 17),
                Image.asset('assets/images/profile_icon.png',
                    width: 32, height: 32),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => ChangeUserNameDialog(
                            onSubmit:
                                context.read<AuthController>().changeUserName));
                  },
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: darkGreyColor),
                          children: [
                            TextSpan(
                                text: context.select<AuthController, String>(
                                    (value) => value.userName),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            const TextSpan(text: '님'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset('assets/images/edit_icon.png',
                          width: 16, height: 16)
                    ],
                  ),
                ),
              ],
            ),

            const Divider(
              color: lightBlueColor,
              thickness: 1,
            ),

            // 미션수행 기록
            ListTile(
              leading: Image.asset(
                'assets/images/book_icon.png',
                width: 24,
                height: 24,
              ),
              title: const Text(
                '미션수행 기록',
                style:
                    TextStyle(fontWeight: FontWeight.w300, color: blackColor),
              ),
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
              leading: Image.asset('assets/images/settings_icon.png',
                  width: 24, height: 24),
              title: const Text('설정'),
              onTap: () {
                Navigator.of(context).pushNamed(SettingsScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _GoodsQuantity extends StatelessWidget {
  const _GoodsQuantity({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int quantity =
        context.select<AuthController, int>((value) => value.goodsQuantity);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Image.asset(
            'assets/images/fish_icon.png',
            width: 18,
            height: 18,
          ),
          const SizedBox(width: 8),
          Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 16, color: blackColor),
          ),
        ],
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
            icon: Icon(Icons.storefront_rounded ,size: 34, color: Colors.grey.shade300,),
            activeIcon: Icon(Icons.storefront_rounded ,size: 34, color: blueColor100,),
          ),
          BottomNavigationBarItem(
            label: '미션',
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
