import 'package:amond/presentation/controllers/grow/grow_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    final imageUrl = context
        .select<GrowViewModel, String>((value) => value.character.imageUrl);
    // final species = context.select<GrowViewModel, String>((value) => value.character.species);
    // final stage = context.select<GrowViewModel, int>((value) => value.character.currentStage);

    return AnimatedOpacity(
      curve: Curves.easeInQuint,
      opacity: avatarIsVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: GrowViewModel.fadeDuration),
      child: GestureDetector(
        onTap: () {
          // FA 로그
          FirebaseAnalytics.instance.logEvent(name: '캐릭터_터치');
        },
        child: CachedNetworkImage(
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}