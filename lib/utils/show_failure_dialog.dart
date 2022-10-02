import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showFailureDialog(BuildContext context, String errMsg) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text(errMsg),
          content: const Text('다시 시도해주세요.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('확인'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(errMsg),
          content: const Text('다시 시도해주세요.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
