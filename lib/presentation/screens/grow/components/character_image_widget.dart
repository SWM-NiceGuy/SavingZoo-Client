import 'package:amond/presentation/controllers/grow/grow_view_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharacterImageWidget extends StatelessWidget {
  const CharacterImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatarIsVisible =
        context.select<GrowViewModel, bool>((value) => value.avatarIsVisible);
    // final imageUrl = context
    //     .select<GrowViewModel, String>((value) => value.character.imageUrl);
    final species = context.select<GrowViewModel, String>((value) => value.character.species);
    final stage = context.select<GrowViewModel, int>((value) => value.character.currentStage);
    final feedAnimationPlaying = context.select<GrowViewModel, bool>((value) => value.feedAnimationPlaying);
    final playAnimationPlaying = context.select<GrowViewModel, bool>((value) => value.playAnimationPlaying);

    String stateString() {
      if (feedAnimationPlaying) {
        return 'feed';
      } else if (playAnimationPlaying) {
        return 'greet';
      } else {
        return 'normal';
      }
    }


    return AnimatedOpacity(
      curve: Curves.easeInQuint,
      opacity: avatarIsVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: GrowViewModel.fadeDuration),
      child: GestureDetector(
        onTap: () {
          // FA 로그
          FirebaseAnalytics.instance.logEvent(name: '캐릭터_터치');
        },
        // child: CachedNetworkImage(
        //   imageUrl: imageUrl,
        // ),
        child: Image.asset('assets/characters/$species/${stateString()}/$stage.gif', fit: BoxFit.cover,)
      ),
    );
  }
}