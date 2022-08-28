import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformBasedIndicator extends StatelessWidget {
  const PlatformBasedIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
    ? const CircularProgressIndicator()
    : const CupertinoActivityIndicator();
  }
}