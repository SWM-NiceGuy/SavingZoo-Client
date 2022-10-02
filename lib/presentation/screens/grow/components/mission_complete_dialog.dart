import 'package:amond/presentation/screens/grow/components/shadow_button.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class MissionCompleteDialog extends StatelessWidget {
  const MissionCompleteDialog({
    Key? key,
    required this.onSubmit,
    required this.reward,
  }) : super(key: key);

  final Function onSubmit;
  final int reward;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: deviceSize.width * 0.8,
        height: deviceSize.height * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColor,
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffEEEFF5),
                Color.fromARGB(255, 211, 214, 222),
              ],
            ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '미션 완수',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Text(
                '+ $reward XP',
                style: const TextStyle(color: expBarColor1, fontSize: 24),
              ),
              const SizedBox(height: 24),
              // 미션 완수 이미지
              Expanded(
                  child: Image.asset('assets/images/pioneer_badge_icon.png')),
                  const SizedBox(height: 24),
              // 이름 입력 Container
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('수행하신 미션이 인증 되었습니다!'),
                  const Text('자세한 인증 내역은 좌측 상단 메뉴의'),
                  RichText(
                    text: TextSpan(
                      children: const [
                        TextSpan(
                            text: '미션수행 기록',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '을 참고해주세요!')
                      ],
                      style: Theme.of(context).textTheme.bodyText2
                    ),
                  )
                ],
              ),
              const SizedBox(height: 36),
              LayoutBuilder(
                builder: (context, constraints) => ShadowButton(
                  width: constraints.maxWidth * 0.8,
                  height: 50,
                  borderRadius: 100,
                  // 이름 유효성 검사
                  onPress: () {
                    Navigator.of(context).pop();
                    onSubmit();
                  },
                  child: Center(
                    child: Text(
                      '확인',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: expTextColor,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
