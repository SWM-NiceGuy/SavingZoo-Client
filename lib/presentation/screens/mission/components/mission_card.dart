import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class MissionCard extends StatefulWidget {
  const MissionCard({
    Key? key,
  }) : super(key: key);

  @override
  State<MissionCard> createState() => _MissionCardState();
}

class _MissionCardState extends State<MissionCard> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        selected = !selected;
      }),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 6,
                  offset: const Offset(4, 4),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  blurRadius: 6,
                  offset: const Offset(-4, -4),
                )
              ]),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 미션 아이콘 (아마 사진이 될 것)
                  Icon(
                    Icons.water_drop,
                    size: 48,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // 미션 내용 및 경험치
                    children: [
                      Text("플로깅", style: TextStyle(fontSize: 24)),
                      Text("+8XP", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const Spacer(),
                  // 미션 성공 여부
                  Image.asset("assets/images/check_icon.png"),
                ],
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
                height: selected ? 80 : 0,
                child: ListView(
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(child: Text("어떤 공원이든 상관없습니다! 공원을 걸으시면서 겸사겸사 쓰레기를 주워봐요!",
                        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 102, 102, 102)),))
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
