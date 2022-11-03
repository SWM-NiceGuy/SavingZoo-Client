import 'package:freezed_annotation/freezed_annotation.dart';

part 'grow_ui_event.freezed.dart';

@freezed
class GrowUiEvent with _$GrowUiEvent {

  const factory GrowUiEvent.levelUp() = LevelUp;
}