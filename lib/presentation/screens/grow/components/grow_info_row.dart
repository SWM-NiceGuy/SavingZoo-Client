import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class GrowInfoRow extends StatelessWidget {
  const GrowInfoRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        Container(
          alignment: Alignment.centerLeft,
          width: 200,
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: kMissionScreenBgColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: textBlueColor200,
            ),
          ),
        )
      ],
    );
  }
}
