import 'package:flutter/material.dart';

class NameValidation with ChangeNotifier {

    bool isValidate = true;

  /// 이름 유효성 검증
  /// 
  /// 유효하면 [true] 아니면 [false]를 반환한다.
  bool validate(String name) {
    
    if (name.length > 8 || name.length < 2) {
      isValidate = false;
      notifyListeners();
      return false;
    }
    
    return true;
  }
}