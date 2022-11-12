import 'package:amond/domain/models/mission_history.dart';
import 'package:amond/domain/repositories/mission_repository.dart';
import 'package:flutter/foundation.dart';

class MissionHistoryViewModel with ChangeNotifier {

  final MissionRepository _missionRepository;

  MissionHistoryViewModel(this._missionRepository);

  List<MissionHistory> _histories = [];
  List<MissionHistory> get histories => _histories;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    
    var loadedHistory = await _missionRepository.getMissionHistories();
    _histories = loadedHistory;

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _histories = [];
    _isLoading = true;
  }
}
