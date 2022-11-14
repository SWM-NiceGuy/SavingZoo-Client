import 'package:json_annotation/json_annotation.dart';

part 'app_notice.g.dart';

@JsonSerializable()
class AppNotice {
  //   "isApply": true,
  // "isRequired": false,
  // "message": "서버 점검이 11/9 11:00~13:00 까지 예정되어 있습니다."

  bool isApply;
  bool? isRequired;
  String? message;

  AppNotice(
      {required this.isApply, this.isRequired, this.message});

  factory AppNotice.fromJson(Map<String, dynamic> json) =>
      _$AppNoticeFromJson(json);
  Map<String, dynamic> toJson() => _$AppNoticeToJson(this);
}
