import 'package:json_annotation/json_annotation.dart';

part 'character_silhouette_images_entity.g.dart';

@JsonSerializable()
class CharacterSilhouetteImagesEntity {

  String stage2SilhouetteUrl;
  String stage3SilhouetteUrl;

  CharacterSilhouetteImagesEntity({
    required this.stage2SilhouetteUrl,
    required this.stage3SilhouetteUrl,
  });

  factory CharacterSilhouetteImagesEntity.fromJson(Map<String, dynamic> json) => _$CharacterSilhouetteImagesEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterSilhouetteImagesEntityToJson(this);
}