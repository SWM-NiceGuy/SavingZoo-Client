import 'dart:async';

import 'package:amond/presentation/controllers/grow/grow_view_model.dart';
import 'package:amond/presentation/screens/mission/util/time_util.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  String get timeInStr => secondsToTimeLeft(remainingSeconds);

  final headerTextStyle = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Color(0xFF505459),
  );

  final bodyTextStyle = const TextStyle(
    fontSize: 12.0,
    color: kBlue,
  );

  late int remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.remainingSeconds;
    if (remainingSeconds != 0) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(PlayButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_timer?.isActive ?? false) {
      return;
    }
    remainingSeconds = widget.remainingSeconds;
    if (remainingSeconds != 0) {
      _startTimer();
    }
  }

    @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
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
                      Text('놀자', style: headerTextStyle),
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

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (remainingSeconds == 1) {
          setState(() {
            timer.cancel();
            remainingSeconds--;
          });
          //
          context.read<GrowViewModel>().clearPlayTime();
        } else {
          setState(() {
            remainingSeconds--;
          });
        }
      },
    );
  }
}
