import 'package:amond/data/entity/banner_info_entity.dart';

class BannerInfo {
  String imageUrl;
  String contentUrl;

  BannerInfo({
    required this.imageUrl,
    required this.contentUrl,
  });

    factory BannerInfo.fromEntity(BannerInfoEntity entity) =>
      _$BannerInfoFromEntity(entity);

    static BannerInfo _$BannerInfoFromEntity(BannerInfoEntity entity) =>
      BannerInfo(
        imageUrl: entity.imageUrl,
        contentUrl: entity.contentUrl,
      );
}