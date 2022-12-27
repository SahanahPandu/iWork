import 'package:eswm/models/attendance_log/attendance_log_paging.dart';

class AttendanceLogData {
  final AttendanceLogPaging? data;
  final String status;
  final String? message;

  const AttendanceLogData({
    required this.data,
    required this.status,
    this.message,
  });

  factory AttendanceLogData.fromJson(json) => AttendanceLogData(
        data: json['data']['attendances'] != null
            ? AttendanceLogPaging.fromJson(json['data']['attendances'])
            : null,
        status: json['status'],
        message: json['message'],
      );
}
