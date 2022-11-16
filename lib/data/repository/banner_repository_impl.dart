import 'package:amond/data/source/network/api/banner_api.dart';
import 'package:amond/domain/models/banner_info.dart';
import 'package:amond/domain/repositories/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerApi _api;
  BannerRepositoryImpl(this._api);
  
  @override
  Future<List<BannerInfo>> getBannerInfo() async {
    final entityList = await _api.getBannerInfo();
    return entityList.map((e) => BannerInfo.fromEntity(e)).toList();
  }

}