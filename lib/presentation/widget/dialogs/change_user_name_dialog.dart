import 'package:amond/presentation/widget/main_button.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class ChangeUserNameDialog extends StatefulWidget {
  const ChangeUserNameDialog({Key? key, required this.onSubmit})
      : super(key: key);

  final Function(String) onSubmit;

  @override
  State<ChangeUserNameDialog> createState() => _ChangeUserNameDialogState();
}

class _ChangeUserNameDialogState extends State<ChangeUserNameDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool _isNameValidate(String name) {
    if (name.length < 2 || name.length > 8) {
      return false;
    }
    return true;
  }

  var _indicateAlert = false;

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
                // 상단 텍스트
                const Text(
                  '닉네임 변경',
                  style: TextStyle(fontSize: 20, color: textBlueColor200),
                ),
                const SizedBox(height: 11),

                // 중앙 이름 변경 탭
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xfff2f2f2),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Text('2 ~ 8자 사이로 입력해주세요.',
                      style: TextStyle(
                          color:
                              _indicateAlert ? Colors.red : const Color(0xffA6A6A6),
                          fontSize: 16)),
                ),

                // 확인 버튼
                MainButton(
                    onPressed: () {
                      if (!_isNameValidate(_controller.text)) {
                        setState(() {
                          _indicateAlert = true;
                        });
                        return;
                      }

                      widget.onSubmit(_controller.text);
                      Navigator.of(context).pop();
                    },
                    width: 149,
                    height: 56,
                    child: const Text('확인'))
              ]),
        ),
      ),
    );
  }
}
