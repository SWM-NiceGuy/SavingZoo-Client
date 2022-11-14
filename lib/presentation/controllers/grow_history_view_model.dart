import 'package:amond/domain/models/grow_history.dart';
import 'package:amond/domain/models/grow_stage.dart';
import 'package:amond/domain/repositories/character_repository.dart';
import 'package:flutter/foundation.dart';

class GrowHistoryViewModel with ChangeNotifier {
  final CharacterRepository _characterRepository;

  GrowHistoryViewModel(this._characterRepository);

  late final GrowHistory _growHistory;
  GrowHistory get history => _growHistory;
  var _index = 0;
  int get index => _index;
  var _isLoading = true;
  bool get isLoading => _isLoading;

  GrowStage get currentIdxStage => _growHistory.stages[index];

  Future<void> fetchData() async {
    _growHistory = await _characterRepository.getGrowHistory();

    // _growHistory = GrowHistory(
    //   petName: '냐옹이',
    //   species: 'otter',
    //   birth: DateTime.fromMillisecondsSinceEpoch(1666939721000),
    //   stages: [
    //     GrowStage(
    //         stage: 1,
    //         level: 1,
    //         growState: true,
    //         weight: '3kg',
    //         height: '4cm',
    //         grownDate: DateTime.fromMillisecondsSinceEpoch(1667269570000)),
    //     GrowStage(
    //         stage: 2,
    //         level: 15,
    //         growState: true,
    //         weight: '5kg',
    //         height: '7cm',
    //         grownDate: DateTime.fromMillisecondsSinceEpoch(1669269570000)),
    //     GrowStage(
    //         stage: 3,
    //         level: 30,
    //         growState: false,
    //         weight: '7kg',
    //         height: '10cm',
    //         grownDate: DateTime.fromMillisecondsSinceEpoch(1672269570000)),
    //   ],
    // );

    _isLoading = false;
    notifyListeners();
  }

  /// 성장 일기의 인덱스를 변경
  void changeIndex({bool forward = true}) {
    if (forward) {
      _index = (_index + 1) % _growHistory.stages.length;
    } else {
      _index == 0 ? _index = _growHistory.stages.length - 1 : _index -= 1;
    }

    notifyListeners();
  }
}
