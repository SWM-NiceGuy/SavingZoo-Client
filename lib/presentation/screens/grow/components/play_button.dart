import 'dart:async';

import 'package:amond/presentation/screens/mission/util/time_util.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

/// 캐릭터와 놀아주기 버튼
///
/// 누르면 재사용 타이머가 시작된다
class PlayButton extends StatefulWidget {
  final int remainingSeconds;
  final VoidCallback onClick;

  const PlayButton({
    required this.remainingSeconds,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  int remainingSeconds = 0;

  String get timeInStr => secondsToTimeLeft(remainingSeconds);

  late Timer _timer;

  final headerTextStyle = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Color(0xFF505459),
  );

  final bodyTextStyle = const TextStyle(
    fontSize: 12.0,
    color: kBlue,
  );

  /// 매 초마다 남은 시간을 감소시키는 타이머를 시작한다
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds <= 0) {
        _timer.cancel();
        return;
      }

      setState(() => remainingSeconds--);
    });
  }

  /// 타이머를 중지한다
  void stopTimer() => _timer.cancel();

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.remainingSeconds;
    startTimer();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kCharacterActionButtonColor,
      borderRadius: BorderRadius.circular(20.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        splashColor: kBlue.withOpacity(0.15),
        highlightColor: kBlue.withOpacity(0.1),
        onTap: remainingSeconds > 0 ? null : widget.onClick,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 28.0,
                  backgroundColor: Colors.white,
                  child:
                      Image.asset('assets/images/hands_icon.png', height: 28.0),
                ),
                const SizedBox(width: 16.0),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('밥먹자', style: headerTextStyle),
                      const SizedBox(height: 4.0),
                      Text('경험치가 5 증가해요', style: bodyTextStyle)
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                if (remainingSeconds > 0)
                  Container(
                    constraints: const BoxConstraints(minWidth: 100),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Center(
                      child:
                          Text(timeInStr, style: const TextStyle(color: kBlue)),
                    ),
                  ),
              ],
            )),
      ),
    );
  }
}
