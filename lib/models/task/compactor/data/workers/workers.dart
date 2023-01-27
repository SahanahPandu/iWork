import 'user_id/user_id.dart';

class Worker {
  Worker({
    this.id,
    this.userId,
    this.attendanceDate,
    this.clockInAt,
    this.clockOutAt,
  });

  int? id;
  UserId? userId;
  String? attendanceDate;
  String? clockInAt;
  String? clockOutAt;

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        id: json["id"],
        userId:
            json["user_id"] != null ? UserId.fromJson(json["user_id"]) : null,
        attendanceDate: json["attendance_date"] ?? "",
        clockInAt: json["clock_in_at"] ?? "",
        clockOutAt: json["clock_out_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId!.toJson(),
        "attendance_date": attendanceDate,
        "clock_in_at": clockInAt,
        "clock_out_at": clockOutAt,
      };
}
