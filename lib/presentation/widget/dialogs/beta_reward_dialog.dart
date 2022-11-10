import 'package:amond/presentation/widget/main_button.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class BetaRewardDialog extends StatelessWidget {
  const BetaRewardDialog({
    Key? key,
    required this.reward,
    required this.onPop,
  }) : super(key: key);

  final int reward;
  final VoidCallback onPop;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(26.0))),
        child: SizedBox(
          width: deviceSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 상단 텍스트
                  const Text(
                    '기존 아몬드 유저 보상',
                    style: TextStyle(fontSize: 20, color: textBlueColor200),
                  ),
                  const SizedBox(height: 4),
    
                  // 중앙 텍스트
                  const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text(
                      '아몬드가 멸종위기 동물 임시보호소로 새롭게\n개편되었습니다!',
                      style: TextStyle(fontSize: 16, color: darkGreyColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
    
                  Image.asset(
                    'assets/images/third_apple_avatar.png',
                    width: 150,
                    fit: BoxFit.cover,
                  ),
    
                  const SizedBox(height: 29),
    
                  Align(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('이전에 획득하신 경험치는 ',
                            style: TextStyle(color: greyColor)),
                        const Text(
                          '10XP = ',
                          style: TextStyle(fontSize: 14, color: textBlueColor200),
                        ),
                        Image.asset('assets/images/fish_icon.png',
                            width: 12, height: 12),
                        const Text(
                          '1개',
                          style: TextStyle(color: textBlueColor200),
                        ),
                        const Text(
                          '로 환산됩니다.',
                          style: TextStyle(color: greyColor),
                        ),
                      ],
                    ),
                  ),
    
                  const SizedBox(height: 29),
    
                  // 확인 버튼
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Text('   총 ',
                              style: TextStyle(fontSize: 18, color: blackColor)),
                          Image.asset('assets/images/fish_icon.png',
                              width: 25, height: 25),
                          Text(' $reward 획득',
                              style: const TextStyle(
                                  fontSize: 18, color: blackColor)),
                        ],
                      ),
                      MainButton(
                        onPressed: () {
                          onPop.call();
                          Navigator.of(context).pop();
                        },
                        height: 56,
                        width: 149,
                        child: const Text('받기'),
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
