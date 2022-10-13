import 'package:amond/presentation/controllers/grow_controller.dart';
import 'package:amond/presentation/screens/grow/components/level_system.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LevelWidget extends StatelessWidget {
  const LevelWidget({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    context.select<GrowController, int>((value) => value.character.currentExp);
    final character = Provider.of<GrowController>(context, listen: false).character;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              24, 8.0, 24, 0.0),
          child: LevelSystem(
            width: width,
            height: 12.0,
            level: character.level,
            currentExp: character.currentExp,
            maxExp: character.maxExp,
            percentage: character.expPct,
          ),
        ),
      ],
    );
  }
}