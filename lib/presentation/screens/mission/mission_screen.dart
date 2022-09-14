import 'package:amond/ui/colors.dart';
import 'package:flutter/material.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({Key? key}) : super(key: key);

  static const String routeName = "/mission";

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: 3,
          itemBuilder: (context, index) => Container(
            // 카드 간의 상하 간격
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: Icon(Icons.water_drop, color: Colors.blue,),
                  title: Text("티끌모아 태산", style: TextStyle(fontSize: 20),),
                  subtitle: Text("물을 한 방울이라도 아끼는 것이 지구에 도움이 된다는 것을 아시나요? 양치할 때 겸사겸사 물을 받아놓고 해봐요!"),
                  trailing: index == 1 ?  Icon(Icons.check_box_outline_blank) : Icon(Icons.check_box_outlined, color: Colors.green,),
                ),
              )
            ),
          ),
        );
  }
}
