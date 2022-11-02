
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class FeedButton extends StatelessWidget {
  final VoidCallback onClick;
  final bool enabled;

  const FeedButton({
    Key? key,
    required this.onClick,
    this.enabled = true,
  }) : super(key: key);

  final headerTextStyle = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Color(0xFF505459),
  );
  final bodyTextStyle = const TextStyle(
    fontSize: 12.0,
    color: kBlue,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kCharacterActionButtonColor,
      borderRadius: BorderRadius.circular(20.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        splashColor: kBlue.withOpacity(0.15),
        highlightColor: kBlue.withOpacity(0.1),
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 28.0,
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/fish_icon.png', height: 28.0),
              ),
              const SizedBox(width: 16.0),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('밥먹자', style: headerTextStyle),
                    const SizedBox(height: 4.0),
                    Text('경험치가 10 증가해요', style: bodyTextStyle)
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              // Container(
              //   padding: const EdgeInsets.all(8.0),
              //   decoration: BoxDecoration(
              //     color: Colors.white.withOpacity(0.5),
              //     borderRadius: BorderRadius.circular(7.0),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
