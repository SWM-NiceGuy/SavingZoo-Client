import 'package:flutter/material.dart';

class SettingsAlertContainer extends StatelessWidget {
  const SettingsAlertContainer({
    Key? key, required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(
                  255, 255, 255, 0.8),
              offset: Offset(-2, -2),
              blurRadius: 5),
              BoxShadow(
              color: Color(0xffA6B4C8),
              offset: Offset(2, 2),
              blurRadius: 5)
        ],
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(238, 240, 245, 1),
              Color.fromRGBO(230, 233, 239, 1)
            ]),
      ),
      child: Row(
        children: [
          const Icon(Icons.error, color: Color(0xffA3C908),),
          const SizedBox(width: 8),
           Expanded(
             child: Center(
              child: Text(
                content,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Color.fromRGBO(52, 52, 52, 1),
                    fontSize: 14,
                    ),
                    softWrap: true,
              ),
                                     ),
           ),
        ],
      ),
    );
  }
}
