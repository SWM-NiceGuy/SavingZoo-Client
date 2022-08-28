import 'package:amond/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _qrString = "Empty Scan Code";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: SizedBox(
        height: 80,
        width: 80,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () => _toQrScanner(),
            child: const Icon(
              Icons.qr_code_scanner,
              size: 28,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(child: Text(_qrString)),
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
}
