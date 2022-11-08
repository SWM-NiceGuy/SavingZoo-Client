import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:amond/presentation/controllers/mission_view_model.dart';
import 'package:amond/presentation/widget/dialogs/mission_complete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> checkMissionResult(BuildContext context) async {
    final result = await context.read<MissionViewModel>().getMissionResult();
    if (!result.hasNoResult) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => MissionCompleteDialog(
                result: result,
                onPop: () async {
                  context
                      .read<MissionViewModel>()
                      .confirmResult(result.completedMissionIds)
                      .then((_) {
                    context.read<AuthController>().setGoodsQuantity();
                  });
                },
              ));
    }
  }