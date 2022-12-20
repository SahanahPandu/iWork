import 'package:eswm/models/schedule/filter/schedule_filter_data.dart';

class ScheduleFilter {
  ScheduleFilter({
    required this.data,
    required this.status,
    this.message,
  });

  final dynamic data;
  final String status;
  final String? message;

  factory ScheduleFilter.fromJson(json) => ScheduleFilter(
        data: ScheduleFilterData.fromJson(json['data']),
        status: json['status'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}
