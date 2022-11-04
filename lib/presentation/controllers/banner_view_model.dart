import 'package:amond/domain/models/banner_info.dart';
import 'package:amond/domain/repositories/banner_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BannerViewModel with ChangeNotifier {
  final BannerRepository _repository;
  BannerViewModel(this._repository);

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<BannerInfo> _infos = [];
  List<BannerInfo> get infos => _infos;

  Future<void> setBannerInfo() async {
    //  _infos = await _repository.getBannerInfo();
    await Future.delayed(const Duration(seconds: 1));

     _isLoading = false;
     notifyListeners();
  }
}