import 'package:eswm/models/schedule/schedule_details.dart';

class ScheduleData {
  ScheduleData({
    required this.data,
    required this.status,
    this.message,
  });

  final dynamic data;
  final String status;
  final String? message;

  factory ScheduleData.fromJson(json) => ScheduleData(
        data: ScheduleDetails.fromJson(json['data']['details']),
        status: json['status'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}
