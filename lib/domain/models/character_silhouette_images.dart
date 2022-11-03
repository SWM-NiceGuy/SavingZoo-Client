import 'package:amond/data/entity/character_silhouette_images_entity.dart';

class CharacterSilhouetteImages {
  String image2;
  String image3;

  CharacterSilhouetteImages({
    required this.image2,
    required this.image3,
  });

  factory CharacterSilhouetteImages.fromEntity(CharacterSilhouetteImagesEntity entity) =>
      _$CharacterSilhouetteImagesFromEntity(entity);

  static CharacterSilhouetteImages _$CharacterSilhouetteImagesFromEntity(CharacterSilhouetteImagesEntity entity) => CharacterSilhouetteImages(
        image2: entity.stage2SilhouetteUrl,
        image3: entity.stage3SilhouetteUrl,
      );
}