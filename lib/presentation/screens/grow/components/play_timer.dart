import 'dart:async';

import 'package:amond/presentation/controllers/grow_view_model.dart';
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
  late int _time;
  Timer? _timer;

  String format(int t) {
    Duration d = Duration(seconds: t);
    return d.toString().split('.').first.padLeft(8, "0");
  }

  @override
  void initState() {
    super.initState();
    _time = widget.time;
    if (_time != 0) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(PlayTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_timer?.isActive ?? false) {
      return;
    }
    _time = widget.time;
    if (_time != 0) {
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _time > 0
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
                  format(_time),
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
        if (_time == 1) {
          setState(() {
            timer.cancel();
            _time--;
          });
          context.read<GrowViewModel>().togglePlayButton(isActive: true);
        } else {
          setState(() {
            _time--;
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
