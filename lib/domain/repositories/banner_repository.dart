import 'package:amond/domain/models/banner_info.dart';

abstract class BannerRepository {
  Future<List<BannerInfo>> getBannerInfo();
}