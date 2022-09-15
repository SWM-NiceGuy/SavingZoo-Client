import 'package:amond/presentation/controllers/name_validation.dart';
import 'package:amond/presentation/screens/grow/components/shadow_button.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharacterNameInput extends StatelessWidget {
  const CharacterNameInput({
    Key? key,
    required this.minSize,
    required this.onSubmit,
  }) : super(key: key);

  final double minSize;
  final Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    final nameValidation = context.watch<NameValidation>();

    return Center(
      child: Container(
        width: minSize * 5 / 6,
        height: (minSize * 5 / 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(minSize / 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    '이름 입력',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const Text('캐릭터의 이름을 입력해주세요. (2-8자)'),
              // 이름 입력 Container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(4, 4),
                      )
                    ]),
                // 이름 입력 창
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: controller,
                    ),
                  ),
                ),
              ),
              nameValidation.isValidate
                  ? const Text('❗️주의: 이후에 변경할 수 없습니다')
                  : const Text(
                      "이름이 유효하지 않습니다!",
                      style: TextStyle(color: Colors.red),
                    ),
              ShadowButton(
                width: minSize / 2,
                height: minSize / 8,
                borderRadius: minSize / 8,
                // 이름 유효성 검사
                onPress: () {
                  if (!nameValidation.validate(controller.text)) {
                    return;
                  }
                  onSubmit(controller.text);
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Text(
                    '확인',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: expTextColor,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
