import 'package:json_annotation/json_annotation.dart';

part 'banner_info_entity.g.dart';

@JsonSerializable()
class BannerInfoEntity {

  String imageUrl;
  String contentUrl;

  BannerInfoEntity({
    required this.imageUrl,
    required this.contentUrl,
  });

  factory BannerInfoEntity.fromJson(Map<String, dynamic> json) => _$BannerInfoEntityFromJson(json);
  Map<String, dynamic> toJson() => _$BannerInfoEntityToJson(this);
}