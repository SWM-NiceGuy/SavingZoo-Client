import 'package:amond/ui/colors.dart';
import 'package:amond/utils/push_notification.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool? _pushNotificationPermission;

  @override
  void initState() {
    super.initState();
    getPushNotificationPermission().then((value) {
      setState(() {
         _pushNotificationPermission = value;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        elevation: 0,
        foregroundColor: blackColor,
        shape: const Border(bottom: BorderSide(color: Color(0xffd7d7d7))),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('미션 수행 푸시 알림'),
            value: _pushNotificationPermission ?? false,
            onChanged: (bool value) {
              setState(() {
                _pushNotificationPermission = value;
              });
              setPushNotificationPermission(value);
            },
            secondary: const Icon(Icons.notifications),
          )
        ],
      ),
    );
  }
}
