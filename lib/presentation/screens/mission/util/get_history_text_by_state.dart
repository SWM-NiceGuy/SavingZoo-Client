import 'package:amond/domain/models/mission_state.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

Widget getHistoryTextByState(MissionState state) {
  switch (state) {
    case MissionState.incomplete:
      return Container();
    case MissionState.wait:
      return const Text('인증 대기중', style: TextStyle(color: Color(0xff787878)));
    case MissionState.completed:
      return const Text('성공', style: TextStyle(color: successColor));
    case MissionState.rejected:
      return const Text('반려', style: TextStyle(color: failureColor));
  }
}