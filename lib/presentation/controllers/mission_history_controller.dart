import 'package:amond/domain/models/mission_history.dart';
import 'package:flutter/foundation.dart';

class MissionHistoryController with ChangeNotifier {
  late List<MissionHistory> _histories;
  List<MissionHistory> get histories => _histories;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
}
