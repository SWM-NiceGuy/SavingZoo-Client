import 'package:amond/domain/models/mission_history.dart';
import 'package:amond/domain/models/mission_state.dart';
import 'package:amond/presentation/screens/mission/util/get_history_text_by_state.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key? key,
    required this.history,
  }) : super(key: key);

  final MissionHistory history;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              // 수행 시간
              Text('${history.date.month}.${history.date.day}'),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 기록 내용
                  Text('${history.type}${history.missionName}'),
                  // 성공 여부
                  getHistoryTextByState(history.state) 
                ],
              ),
              const Spacer(),
              // 보상
              if (history.state == MissionState.accepted)
              Text('+ ${history.reward}XP',
                  style: const TextStyle(
                      fontSize: 18,
                      color: successColor,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: const Color(0xffd7d7d7),
        )
      ],
    );
  }
}