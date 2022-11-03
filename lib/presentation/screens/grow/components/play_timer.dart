import 'dart:async';

import 'package:amond/presentation/controllers/grow/grow_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayTimer extends StatefulWidget {
  const PlayTimer({Key? key, required this.time, required this.width})
      : super(key: key);

  final int time;
  final double width;

  @override
  State<PlayTimer> createState() => _PlayTimerState();
}

class _PlayTimerState extends State<PlayTimer> {

  String format(int t) {
    Duration d = Duration(seconds: t);
    return d.toString().split('.').first.padLeft(8, "0");
  }
  
  late int remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.time;
    if (remainingSeconds != 0) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(PlayTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_timer?.isActive ?? false) {
      return;
    }
    remainingSeconds = widget.time;
    if (remainingSeconds != 0) {
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return remainingSeconds > 0
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            width: widget.width + 20,
            decoration: BoxDecoration(
              color: const Color(0xffEEBBB5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  format(remainingSeconds),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        : const SizedBox();
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
          context.read<GrowViewModel>().clearPlayTime();
        } else {
          setState(() {
            remainingSeconds--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
