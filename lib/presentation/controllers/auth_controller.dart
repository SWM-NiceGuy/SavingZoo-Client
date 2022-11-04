import 'package:amond/domain/usecases/member/member_use_cases.dart';
import 'package:amond/utils/auth/auth_info.dart';
import 'package:amond/utils/auth/do_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController with ChangeNotifier {
  String? _token;
  SharedPreferences? _prefs;
  final MemberUseCases _memberUseCases;

  String? get token => _token;

  AuthController(this._memberUseCases);

  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  String? _loginType = '';
  String? get loginType => _loginType;

  String _userName = '';
  String get userName => _userName;

  int _goodsQuantity = 0;
  int get goodsQuantity => _goodsQuantity;

  bool get isTokenExists => _token != null;

  /// 앱 시작시 토큰 설정 (자동로그인)
  ///
  /// 토큰 설정이 성공하면 [true]를 반환
  /// 실패하면 [false]를 반환
  Future<bool> setToken() async {
    final prefs = await this.prefs;
  try {
    _token = prefs.getString("jwt");
    _loginType = prefs.getString('loginType');

    // 전역으로 토큰 설정
    globalToken = _token;
    // 토큰이 없다면 [false] 반환
    if (_token == null) {
      return false;
    }
    
  } catch (error) {
    rethrow;
  }
    notifyListeners();
    return true;
  }

  Future<void> login(LoginInfo info) async {
    final prefs = await this.prefs;
    try {
      // 로그인을 시도하여 서버에서 토큰을 받아온다.
      final jwt = await _memberUseCases.login(info);

      // 토큰, 로그인 타입을 SharedPreferences에 저장
      await prefs.setString('jwt', jwt);
      await prefs.setString('loginType', info.provider);
      _loginType = info.provider;
      await setToken();


      await setUserName();
      await setGoodsQuantity();
    } catch (error) {
      // print(error);
      rethrow;
    }
  }

  /// 로그아웃 함수
  ///
  /// [SharedPreferences]에 저장되어 있는 jwt 삭제
  Future<void> logout() async {
    final prefs = await this.prefs;
    try {
        await prefs.remove('jwt');
        await prefs.remove('loginType');
        _loginType = null;
        globalToken = null;
      } catch (error) {
        // print('로그아웃 실패 $error');
        rethrow;
      }
    }

  /// 회원 탈퇴 함수
  ///
  /// request body에 보낼 추가 정보가 있으면 [additional]에 전달
  ///
  /// 각각 회원 탈퇴후 sharedPreferences에서 login정보를 제거
  Future<void> resign([Map<String, String>? additional]) async {
    final prefs = await this.prefs;

    try {
      await _memberUseCases.resign(prefs.getString('loginType')!, additional);
      prefs.remove('loginType');
      prefs.remove('jwt');
      _loginType = null;
      globalToken = null;
      prefs.clear();
    }
    catch (error) {
      rethrow;
    }
  }

  Future<void> setUserName() async {
    _userName = await _memberUseCases.getUserName();
  }

  Future<void> setGoodsQuantity() async {
    _goodsQuantity = await _memberUseCases.getGoodsQuantity();
    notifyListeners();
  }

  Future<void> changeUserName(String name) async {
    await _memberUseCases.changeUserName(name);
    _userName = name;
    notifyListeners();
  }
}
