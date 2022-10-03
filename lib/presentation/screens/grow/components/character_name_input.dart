import 'package:amond/presentation/controllers/name_validation.dart';
import 'package:amond/presentation/screens/grow/components/shadow_button.dart';
import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharacterNameInput extends StatefulWidget {
  const CharacterNameInput(
      {Key? key, required this.onSubmit, required this.imageUrl})
      : super(key: key);

  final Function(String) onSubmit;
  final String imageUrl;

  @override
  State<CharacterNameInput> createState() => _CharacterNameInputState();
}

class _CharacterNameInputState extends State<CharacterNameInput> {
  var controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nameValidation = context.watch<NameValidation>();
    final deviceSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
         bottom: MediaQuery.of(context).viewInsets.bottom),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Center(
          child: Container(
            width: deviceSize.width * 0.8,
            height: deviceSize.height * 0.65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: backgroundColor,
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xffEEEFF5),
                    Color.fromARGB(255, 211, 214, 222),
                  ],
                ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
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
                  // 캐릭터 이미지
                  Expanded(child: Image.network(widget.imageUrl)),
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
                  const SizedBox(height: 36),
                  nameValidation.isValidate
                      ? const Text('❗️주의: 이후에 변경할 수 없습니다')
                      : const Text(
                          "이름이 유효하지 않습니다!",
                          style: TextStyle(color: Colors.red),
                        ),
                  LayoutBuilder(
                    builder: (context, constraints) => ShadowButton(
                      width: constraints.maxWidth * 0.8,
                      height: 50,
                      borderRadius: 100,
                      // 이름 유효성 검사
                      onPress: () {
                        if (!nameValidation.validate(controller.text)) {
                          return;
                        }
                        widget.onSubmit(controller.text);
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
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
