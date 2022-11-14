import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class MemorialScreen extends StatelessWidget {
  const MemorialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('추억 저장소'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '멸종위기 동물들과의 추억이\n담긴 추억저장소에요',
                textAlign: TextAlign.center,
                style: TextStyle(color: darkGreyColor, fontSize: 16),
              ),
              const SizedBox(height: 22),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: lightBlueColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, mainAxisSpacing: 60, crossAxisSpacing: 20),
                  children: List.generate(
                      9,
                      (index) => Container(
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
