import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class LevelSystem extends StatelessWidget {
  final double width;
  final double height;
  final int level;
  final int currentExp;
  final int maxExp;
  final double percentage;

  const LevelSystem({
    required this.width,
    required this.height,
    required this.level,
    required this.currentExp,
    required this.maxExp,
    required this.percentage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'LV$level',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  color: blackColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${currentExp}xp / ${maxExp}xp',
                    style: TextStyle(color: blackColor),
                  ),
                  SizedBox(width: 4.0),
                  Icon(
                    Icons.info_outline,
                    color: Color(0xff919191),
                    size: 18.0,
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height),
            color: backgroundColor,
            border: Border.all(color: Colors.white, width: 0.15),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFC6CEDA),
                blurRadius: 3.0,
                offset: Offset(0, -1.5),
              ),
              BoxShadow(
                color: Color(0xFFFEFEFF),
                blurRadius: 3.0,
                offset: Offset(0, 1.5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(height / 2),
            child: LinearProgressIndicator(
              value: percentage,
              // backgroundColor: Colors.grey.shade300,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation(Color(0xFF96CE5F)),
            ),
          ),
        ),
      ],
    );
  }
}
