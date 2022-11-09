import 'package:amond/utils/version/app_version.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_status.g.dart';

@JsonSerializable()
class AppStatus {
  final bool required;
  final String latestVersion;
  final String releaseNote;

  bool get isLatest {
    return latestVersion == currentAppStatus.latestVersion;
  }

  AppStatus({
    required this.latestVersion,
    required this.releaseNote,
    required this.required,
  });

  factory AppStatus.fromJson(Map<String, dynamic> json) =>
      _$AppStatusFromJson(json);
  Map<String, dynamic> toJson() => _$AppStatusToJson(this);
}
