import 'package:amond/presentation/controllers/mission_controller.dart';
import 'package:amond/presentation/controllers/mission_detail_controller.dart';
import 'package:amond/utils/show_platform_based_dialog.dart';
import 'package:amond/widget/platform_based_indicator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MissionDetailBottomBar extends StatelessWidget {
  const MissionDetailBottomBar({
    Key? key,
    required this.reward,
  }) : super(key: key);

  final int reward;

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        height: kBottomNavigationBarHeight + 24,
        child: Consumer<MissionDetailController>(
          builder: (context, controller, _) => Row(
            children: [
              // 미션 state에 따라 버튼이 달라져야 함
              controller.isSubmitting
                  ? SizedBox(
                      width: deviceSize.width * 0.65,
                      child: const Center(child: PlatformBasedIndicator()),
                    )
                  : ElevatedButton(
                      // 미션 인증버튼
                      onPressed: controller.mission.state == 'INCOMPLETE' ||
                              controller.mission.state == 'REJECTED'
                          ? () async {

                              // FA 로그
                              FirebaseAnalytics.instance.logEvent(
                                  name: '미션_인증_터치',
                                  parameters: {
                                    '미션id': controller.missionId,
                                    '미션이름': controller.mission.name,
                                    '상태': controller.mission.state,
                                    '보상': controller.mission.reward,
                                  });
                              // 카메라로 이미지 선택
                              final ImagePicker picker = ImagePicker();
                              XFile? image = await picker.pickImage(
                                  source: ImageSource.camera, imageQuality: 35);

                              if (image == null) {
                                // FA 로그
                                FirebaseAnalytics.instance.logEvent(
                                    name: '미션_인증_취소',
                                    parameters: {
                                    '미션id': controller.missionId,
                                    '미션이름': controller.mission.name,
                                    '상태': controller.mission.state,
                                    '보상': controller.mission.reward,
                                    });
                                return;
                              }

                              // FA 로그
                              FirebaseAnalytics.instance.logEvent(
                                  name: '미션_인증_제출',
                                  parameters: {
                                    '미션id': controller.missionId,
                                    '미션이름': controller.mission.name,
                                    '상태': controller.mission.state,
                                    '보상': controller.mission.reward,
                                  });

                              // 미션 업로드 로직
                              // 업로드

                              controller.submit(image.path).then((_) {
                                context
                                    .read<MissionController>()
                                    .changeMissionToWait(controller.missionId);
                              }).onError((_, __) {
                                showPlatformBasedDialog(
                                    context, '사진 전송에 실패했습니다.', '다시 시도해주세요.');
                              });
                            }
                          : null,
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(
                            deviceSize.width * 0.65,
                            kBottomNavigationBarHeight - 10)),
                        overlayColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.transparent;
                          }
                          return null;
                        }),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return const Color.fromARGB(255, 103, 160, 47);
                          } else if (states.contains(MaterialState.disabled)) {
                            return Colors.grey;
                          }
                          return const Color(0xff96CE5F);
                        }),
                      ),
                      child: Text(controller.stateToButtonText,
                          style: const TextStyle(fontSize: 24)),
                    ),
              SizedBox(width: deviceSize.width * 0.05 - 5),
              // 얻는 보상
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    "+${reward}XP",
                    style: const TextStyle(fontSize: 20),
                  ),
                  if (controller.mission.state == "COMPLETED")
                    Image.asset(
                      'assets/images/check_icon.png',
                      width: 40,
                      height: 40,
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
