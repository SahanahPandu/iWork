import '../../workers/user_id/user_id.dart';
import 'user_attendance_id/user_attendance_id.dart';

class WorkerSchedule {
  WorkerSchedule({
    this.id,
    this.scMainId,
    this.userId,
    this.userAttendanceId,
  });

  int? id;
  int? scMainId;
  UserId? userId;
  UserAttendanceId? userAttendanceId;

  factory WorkerSchedule.fromJson(Map<String, dynamic> json) => WorkerSchedule(
        id: json["id"],
        scMainId: json["sc_main_id"],
        userId: UserId.fromJson(json["user_id"]),
        userAttendanceId: json["user_attendance_id"] == null
            ? null
            : UserAttendanceId.fromJson(json["user_attendance_id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sc_main_id": scMainId,
        "user_id": userId!.toJson(),
        "user_attendance_id":
            userAttendanceId == null ? null : userAttendanceId!.toJson(),
      };
}
