import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // 버튼 색깔
        gradient: const LinearGradient(
          colors: [
            buttonGradientColor1,
            buttonGradientColor2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          if (onPressed != null)
            const BoxShadow(
                color: buttonShadowColor, offset: Offset(0, 10), blurRadius: 20)
        ],
        borderRadius: BorderRadius.circular(100),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
          fixedSize: MaterialStateProperty.all(Size(width ?? 0, height ?? 0)),
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.transparent;
            }
            return null;
          }),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              // 버튼 눌렀을 때 색
              return blueColor100;
            } else if (states.contains(MaterialState.disabled)) {
              // 버튼 비활성화 색
              return Colors.grey;
            }
            return Colors.transparent;
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              // 버튼 비활성화 foreground color
              return Colors.white;
            }
            return null;
          }),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: child,
      ),
    );
  }
}
