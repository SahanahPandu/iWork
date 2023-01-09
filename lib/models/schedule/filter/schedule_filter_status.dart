import 'package:json_annotation/json_annotation.dart';

class ScheduleFilterStatus {
  final int id;
  final String code;
  final String name;
  final String category;

  @JsonKey(defaultValue: 0)
  int? isClicked;

  ScheduleFilterStatus({
    required this.id,
    required this.code,
    required this.name,
    required this.category,
    this.isClicked,
  });

  factory ScheduleFilterStatus.fromJson(json) => ScheduleFilterStatus(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        category: json['category'],
      );
}
