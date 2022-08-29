import 'package:amond/presentation/screens/auth/auth_screen.dart';
import 'package:amond/presentation/screens/grow/grow_screen.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'qr_scanner.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String routeName = '/main-screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('로그아웃'),
              onTap: () async => _logout(),
            )
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: Color(0xFF96CE5F)),
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GrowScreen(),
      ),
    );
  }

  /// 카메라 권한 확인
  ///
  /// 허락되면 [true], 거부되면 [false]를 반환
  Future<bool> _getStatuses() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage, Permission.camera].request();

    if (await Permission.camera.isGranted &&
        await Permission.storage.isGranted) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  void _toQrScanner() async {
    await _getStatuses();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => QrScanner()));
  }

  Future<void> _logout() async {
    try {
      await UserApi.instance.logout();
      print('로그아웃 성공, SDK에서 토큰 삭제');
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => AuthScreen()));
    } catch (error) {
      print('로그아웃 실패, SDK에서 토큰 삭제 $error');
    }
  }
}
