import 'package:amond/presentation/onboarding/onboarding3_screen.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

import '../widget/main_button.dart';

class Onboarding2Screen extends StatelessWidget {
  const Onboarding2Screen({Key? key}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('2/3'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  'assets/images/onboarding2.png',
                  width: deviceSize.width * 0.5,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 50),
                const Text(
                  '미션을 수행해주세요',
                  style: TextStyle(
                      color: darkGreyColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(color: greyColor, fontSize: 16),
                    children: [
                      TextSpan(text: '기존 생활습관 그대로'),
                      TextSpan(
                        text: '겸사겸사 할 수 있는 \n환경 보호미션들',
                        style: TextStyle(
                          color: textBlueColor,
                        ),
                      ),
                      TextSpan(text: '을 통해 멸종위기 동물을 \n성장시킬 수 있어요'),
                    ],
                  ),
                ),
                const Spacer(),
                MainButton(
                    width: deviceSize.width * 0.8,
                    height: 60,
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const Onboarding3Screen())),
                    child: const Text('다음', style: TextStyle(fontSize: 16),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}