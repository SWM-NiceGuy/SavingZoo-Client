import 'package:amond/domain/models/mission_detail.dart';
import 'package:amond/domain/models/mission_state.dart';
import 'package:amond/presentation/controllers/mission_detail_view_model.dart';

import 'package:amond/ui/colors.dart';
import 'package:amond/utils/firebase_analytics.dart';
import 'package:amond/utils/show_platform_based_dialog.dart';

import 'package:amond/presentation/widget/platform_based_indicator.dart';


import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MissionDetailBottomBar extends StatelessWidget {
  const MissionDetailBottomBar({
    Key? key,
    required this.mission,
  }) : super(key: key);

  final MissionDetail mission;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MissionDetailViewModel>();

    Future<void> _onButtonClick() async {
      // 미션을 제출했으면 동작 취소
      if (controller.mission.state == MissionState.wait ||
          controller.mission.state == MissionState.completed) {
        return;
      }

      _isCameraPermissionGranted().then((isGranted) async {
        // 카메라 권한이 거부 되어 있으면
        if (!isGranted) {
          _showCameraDialog(context).then((value) {
            if (value != null && value) {
              openAppSettings();
            }
          });

          return;
        }

        // 카메라 권한이 확인되면
        // FA 로그
        AmondFirebaseAnalytics.logMissionEvent(
          event: FaEvent.touchMissionButton,
          missionId: controller.missionId,
          missionDetail: controller.mission,
        );

        // 카메라로 이미지 선택
        final ImagePicker picker = ImagePicker();
        XFile? image = await picker.pickImage(
            source: ImageSource.camera, imageQuality: 35);

        // 인증을 취소 했을 때 or 카메라를 껐을 때
        if (image == null) {
          // FA 로그
          AmondFirebaseAnalytics.logMissionEvent(
            event: FaEvent.cancelMission,
            missionId: controller.missionId,
            missionDetail: controller.mission,
          );
          return;
        }

        // 사진을 제출 했을때
        // FA 로그
        AmondFirebaseAnalytics.logMissionEvent(
          event: FaEvent.executeMission,
          missionId: controller.missionId,
          missionDetail: controller.mission,
        );

        // 미션 업로드
        // 오류가 있으면 다이얼로그를 띄움
        controller.submit(image.path).onError((_, __) {
          showPlatformBasedDialog(context, '사진 전송에 실패했습니다.', '다시 시도해주세요.');
        });
      });
    }

    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        height: kBottomNavigationBarHeight + 24,
        child: Row(
          children: [
            // 미션 state에 따라 버튼이 달라져야 함
            Expanded(
              child: _CustomButton(
                text: controller.stateToButtonText,
                onClick: controller.mission.state == MissionState.incomplete
                    ? _onButtonClick
                    : null,
                whiteBackground: controller.mission.state == MissionState.wait,
              ),
            ),
            // 사진 제출했을 경우 보여주기
            if (mission.state == MissionState.wait ||
                mission.state == MissionState.completed)
              _MyMissionImage(imageUrl: 'myMissionImage'),
          ],
        ),
      ),
    );
  }

  Future<bool> _isCameraPermissionGranted() async {
    var cameraPermission = await Permission.camera.request();
    return cameraPermission.isGranted;
  }

  Future<bool?> _showCameraDialog(BuildContext context) {
    return showPlatformDialog<bool>(
        context: context,
        builder: (context) => BasicDialogAlert(
              title: const Text("카메라 권한 필요"),
              content: const Text(
                  '미션 인증을 위해서는 카메라 권한이 필요합니다. 설정창에서 카메라 권한을 허용해 주세요'),
              actions: <Widget>[
                BasicDialogAction(
                  title: const Text("취소"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                BasicDialogAction(
                  title: const Text("설정"),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ));
  }
}

/// 흰색과 파란색 배경을 가지는 버튼
class _CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onClick;
  final bool whiteBackground;

  const _CustomButton({
    required this.text,
    this.onClick,
    this.whiteBackground = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(
            color: kBlue.withOpacity(0.5),
            blurRadius: 10.0,
          )
        ],
      ),
      child: TextButton(
        onPressed: onClick,
        style: TextButton.styleFrom(
          primary: whiteBackground ? kBlue : Colors.white,
          backgroundColor: whiteBackground ? Colors.white : kMissionButtonColor,
          padding: const EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
            side: const BorderSide(
              width: 2.0,
              color: kMissionButtonColor,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: whiteBackground ? kBlack : Colors.white,
          ),
        ),
      ),
    );
  }
}

/// 내가 제출한 미션 이미지 위젯
///
/// [imageUrl] - 이미지 주소
///
class _MyMissionImage extends StatelessWidget {
  final String imageUrl;
  const _MyMissionImage({
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: kBlue.withOpacity(0.5),
            blurRadius: 10.0,
            offset: const Offset(0, 5),
          )
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.network(
          imageUrl,
          width: 58.0,
          height: 58.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
