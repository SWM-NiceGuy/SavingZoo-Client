
import 'package:amond/presentation/onboarding/onboarding2_screen.dart';
import 'package:amond/presentation/widget/main_button.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class Onboarding1Screen extends StatelessWidget {
  const Onboarding1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('1/3', style: TextStyle(color: greyColor)),
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
                  'assets/images/onboarding1.png',
                  width: deviceSize.width * 0.5,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 50),
                const Text(
                  '멸종위기 동물을 보살펴주세요',
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
                      TextSpan(
                        text: '아몬드 임시보호소',
                        style: TextStyle(
                          color: textBlueColor200,
                        ),
                      ),
                      TextSpan(text: '기후 변화로 인해 갈 곳을 잃은\n멸종위기 동물들이 맡겨지는 곳이에요')
                    ],
                  ),
                ),
                const Spacer(),
                MainButton(
                    width: deviceSize.width * 0.8,
                    height: 60,
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const Onboarding2Screen())),
                    child: const Text('다음', style: TextStyle(fontSize: 16),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
