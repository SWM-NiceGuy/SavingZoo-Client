import 'package:json_annotation/json_annotation.dart';

part 'app_status.g.dart';

// {
// 	required: boolean (업데이트를 필수로 해야 하는지 체크),
// 	latestVersion: "1.1.1",
// 	releaseNote: "-김남주가 열일했습니다.-이주원은 살살했습니다."
// }

@JsonSerializable()
class AppStatus {
  final bool required;
  final String latestVersion;
  final String releaseNote;

  AppStatus({
    required this.latestVersion,
    required this.releaseNote,
    required this.required,
  });

  factory AppStatus.fromJson(Map<String, dynamic> json) =>
      _$AppStatusFromJson(json);
  Map<String, dynamic> toJson() => _$AppStatusToJson(this);
}
