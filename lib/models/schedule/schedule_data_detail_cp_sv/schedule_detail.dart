import 'package:eswm/models/task/compactor/data/workers/user_roles/user_roles.dart';

import '../../ecuti/ecuti_details.dart';

class Details {
  Details({
    this.id,
    this.vehicleNo,
    this.mainRoute,
    this.scheduleDate,
    this.activityCode,
    this.startScheduleAt,
    this.stopScheduleAt,
    this.startWorkAt,
    this.stopWorkAt,
    this.totalSubRoute,
    this.totalPark,
    this.totalStreet,
    this.statusCode,
    this.vehicleChecklistId,
    this.workerSchedules,
  });

  int? id;
  String? vehicleNo;
  String? mainRoute;
  String? scheduleDate;
  ActivityCode? activityCode;
  String? startScheduleAt;
  String? stopScheduleAt;
  String? startWorkAt;
  String? stopWorkAt;
  int? totalSubRoute;
  int? totalPark;
  int? totalStreet;
  StatusCode? statusCode;
  VehicleChecklistId? vehicleChecklistId;
  List<WorkerSchedule>? workerSchedules;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        vehicleNo: json["vehicle_no"],
        mainRoute: json["main_route"],
        scheduleDate: json["schedule_date"],
        activityCode: ActivityCode.fromJson(json["activity_code"]),
        startScheduleAt: json["start_schedule_at"] ?? "--:--",
        stopScheduleAt: json["stop_schedule_at"] ?? "--:--",
        startWorkAt: json["start_work_at"] ?? "--:--",
        stopWorkAt: json["stop_work_at"] ?? "--:--",
        totalSubRoute: json["total_sub_route"],
        totalPark: json["total_park"],
        totalStreet: json["total_street"],
        statusCode: StatusCode.fromJson(json["status_code"]),
        vehicleChecklistId: json["vehicle_checklist_id"] != null
            ? VehicleChecklistId.fromJson(json["vehicle_checklist_id"])
            : null,
        workerSchedules: json["worker_schedules"] != null
            ? List<WorkerSchedule>.from(
                json["worker_schedules"].map((x) => WorkerSchedule.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle_no": vehicleNo,
        "main_route": mainRoute,
        "schedule_date": scheduleDate,
        "activity_code": activityCode!.toJson(),
        "start_schedule_at": startScheduleAt,
        "stop_schedule_at": stopScheduleAt,
        "start_work_at": startWorkAt,
        "stop_work_at": stopWorkAt,
        "total_sub_route": totalSubRoute,
        "total_park": totalPark,
        "total_street": totalStreet,
        "status_code": statusCode!.toJson(),
        "vehicle_checklist_id": vehicleChecklistId!.toJson(),
        "worker_schedules":
            List<dynamic>.from(workerSchedules!.map((x) => x.toJson())),
      };
}

class ActivityCode {
  ActivityCode({
    this.activityCode,
    this.activityName,
  });

  String? activityCode;
  String? activityName;

  factory ActivityCode.fromJson(Map<String, dynamic> json) => ActivityCode(
        activityCode: json["activity_code"],
        activityName: json["activity_name"],
      );

  Map<String, dynamic> toJson() => {
        "activity_code": activityCode,
        "activity_name": activityName,
      };
}

class StatusCode {
  StatusCode({
    this.code,
    this.name,
  });

  String? code;
  String? name;

  factory StatusCode.fromJson(Map<String, dynamic> json) => StatusCode(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}

class VehicleChecklistId {
  VehicleChecklistId({
    this.id,
    this.statusCode,
  });

  int? id;
  StatusCode? statusCode;

  factory VehicleChecklistId.fromJson(Map<String, dynamic> json) =>
      VehicleChecklistId(
        id: json["id"],
        statusCode: StatusCode.fromJson(json["status_code"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status_code": statusCode!.toJson(),
      };
}

class WorkerSchedule {
  WorkerSchedule({
    this.id,
    this.scMainId,
    this.userId,
    this.userLeaveId,
    this.userAttendanceId,
  });

  int? id;
  int? scMainId;
  UserId? userId;
  EcutiDetails? userLeaveId;
  UserAttendanceId? userAttendanceId;

  factory WorkerSchedule.fromJson(Map<String, dynamic> json) => WorkerSchedule(
        id: json["id"],
        scMainId: json["sc_main_id"],
        userId:
            json["user_id"] != null ? UserId.fromJson(json["user_id"]) : null,
        userLeaveId: json['user_leave_id'] != null
            ? EcutiDetails.fromJson(json['user_leave_id'])
            : null,
        userAttendanceId: json["user_attendance_id"] != null
            ? UserAttendanceId.fromJson(json["user_attendance_id"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sc_main_id": scMainId,
        "user_id": userId!.toJson(),
        "user_attendance_id": userAttendanceId?.toJson(),
      };
}

class UserAttendanceId {
  UserAttendanceId({
    this.id,
    this.userId,
    this.attendanceDate,
    this.clockInAt,
    this.clockOutAt,
  });

  int? id;
  int? userId;
  String? attendanceDate;
  String? clockInAt;
  String? clockOutAt;

  factory UserAttendanceId.fromJson(Map<String, dynamic> json) =>
      UserAttendanceId(
        id: json["id"],
        userId: json["user_id"],
        attendanceDate: json["attendance_date"] ?? "",
        clockInAt: json["clock_in_at"] ?? "--:--",
        clockOutAt: json["clock_out_at"] ?? "--:--",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "attendance_date": attendanceDate,
        "clock_in_at": clockInAt,
        "clock_out_at": clockOutAt,
      };
}

class UserId {
  UserId({
    this.id,
    this.userTypeId,
    this.emsUserId,
    this.contractorUserId,
    this.userDetail,
    this.userRoles,
  });

  int? id;
  int? userTypeId;
  int? emsUserId;
  dynamic contractorUserId;
  UserDetail? userDetail;
  List<UserRole>? userRoles;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"],
        userTypeId: json["user_type_id"],
        emsUserId: json["ems_user_id"],
        contractorUserId: json["contractor_user_id"],
        userDetail: json["user_detail"] != null
            ? UserDetail.fromJson(json["user_detail"])
            : null,
        userRoles: json["user_roles"] != null
            ? List<UserRole>.from(
                json["user_roles"].map((x) => UserRole.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_type_id": userTypeId,
        "ems_user_id": emsUserId,
        "contractor_user_id": contractorUserId,
        "user_detail": userDetail!.toJson(),
      };
}

class UserDetail {
  UserDetail({
    this.id,
    this.name,
    this.loginId,
    this.profilePic,
    this.email,
    this.supervisorId,
  });

  int? id;
  String? name;
  String? loginId;
  String? profilePic;
  String? email;
  int? supervisorId;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        name: json["name"],
        loginId: json["login_id"] ?? "",
        profilePic: json["profile_pic"] ?? "",
        email: json["email"] ?? "",
        supervisorId: json["supervisor_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "login_id": loginId,
        "profile_pic": profilePic,
        "email": email,
        "supervisor_id": supervisorId,
      };
}
