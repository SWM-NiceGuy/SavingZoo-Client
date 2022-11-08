import 'package:amond/presentation/widget/main_button.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportSettings extends StatelessWidget {
  const SupportSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('고객 센터'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "불편하신 점이나 궁금하신 점은 아래의 \n'문의하기'버튼을 통해 문의해주세요.",
              style: TextStyle(
                  fontSize: 16,
                  color: darkGreyColor,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 25),
            Align(
              alignment: Alignment.center,
              child: MainButton(
                onPressed: () async {
                final url = Uri.parse('https://pf.kakao.com/_JLxkxob/chat');
                if (await canLaunchUrl(url)) {
                  launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
                height: 60,
                width: deviceSize.width * 0.9,
                child: const Text('문의하기', style: TextStyle(fontSize: 16),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
