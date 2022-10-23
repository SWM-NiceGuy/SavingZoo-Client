import 'package:amond/domain/models/mission_list.dart';
import 'package:amond/domain/models/mission_state.dart';
import 'package:flutter/material.dart';

class MissionCard extends StatelessWidget {
  final MissionList mission;
  final VoidCallback onClick;

  const MissionCard({
    required this.mission,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: Colors.white.withOpacity(0.6),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF86B2E5).withOpacity(0.25),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              _IconContainer(iconUrl: mission.iconUrl),
              const SizedBox(width: 20),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // 미션 내용 및 경험치
                  children: [
                    Text(
                      mission.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF505459),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Text(
                      '#분리수거',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF969BA2),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              // 미션 성공 여부
              _MissionStateLabel(missionState: mission.state),
            ],
          )),
    );
  }
}

/// 흰색 배경과 아이콘이 합쳐진 컴포넌트
class _IconContainer extends StatelessWidget {
  final String iconUrl;

  const _IconContainer({
    Key? key,
    required this.iconUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68.0,
      height: 68.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
        color: Colors.white,
      ),
      child: Center(
        child: buildIcon(),
      ),
    );
  }

  Widget buildIcon() {
    if (iconUrl.isEmpty) {
      return Image.asset(
        'assets/images/img_placeholder.gif',
        height: 44,
        width: 44,
        fit: BoxFit.cover,
      );
    }

    return Image.network(
      iconUrl,
      height: 44,
      fit: BoxFit.cover,
      loadingBuilder: (_, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        return Image.asset(
          'assets/images/img_placeholder.gif',
          height: 44,
          width: 44,
          fit: BoxFit.cover,
        );
      },
    );
  }
}

class _MissionStateLabel extends StatelessWidget {
  final MissionState missionState;

  const _MissionStateLabel({
    Key? key,
    required this.missionState,
  }) : super(key: key);

  Color get backgroundColor => getBgColor(missionState);
  String get labelText => getLabelText(missionState);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: backgroundColor,
      ),
      child: Text(
        labelText,
        style: const TextStyle(fontSize: 12.0, color: Colors.white),
      ),
    );
  }

  Color getBgColor(MissionState missionState) {
    switch (missionState) {
      case MissionState.wait:
        return const Color(0xFFD1D4D9);
      case MissionState.completed:
        return const Color(0xFFAAC7F3);
      default:
        return Colors.transparent;
    }
  }

  String getLabelText(MissionState missionState) {
    switch (missionState) {
      case MissionState.wait:
        return '대기중';
      case MissionState.completed:
        return '성공';
      default:
        return '';
    }
  }
}
