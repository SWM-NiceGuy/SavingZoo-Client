import 'package:amond/presentation/widget/main_button.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class LevelupDialog extends StatelessWidget {
  const LevelupDialog({Key? key, required this.level, required this.name}) : super(key: key);

  final int level;
  final String name;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(26.0))),
      child: SizedBox(
        width: deviceSize.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '레벨 $level 달성',
                  style: const TextStyle(fontSize: 20, color: textBlueColor200),
                ),
                const SizedBox(height: 34),
                Image.asset('assets/images/levelup_image.png', 
                width: 150, height: 150,),
                const SizedBox(height: 44),
                Text('레벨 $level 달성을 축하드립니다.', style: TextStyle(color: darkGreyColor, fontSize: 16),),
                Text('$name가 새로운 모습으로 성장했어요!', style: TextStyle(color: darkGreyColor, fontSize: 16),),
                const SizedBox(height: 29),
                MainButton(onPressed: () => Navigator.of(context).pop(), child: Text('확인'), width: 149, height: 56)
              ]),
        ),
      ),
    );
  }
}
