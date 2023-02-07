class SupervisorTask {
  SupervisorTask({
    required this.data,
    required this.status,
    this.message,
  });

  SvData data;
  String status;
  dynamic message;

  factory SupervisorTask.fromJson(Map<String, dynamic> json) => SupervisorTask(
        data: SvData.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class SvData {
  SvData({
    this.startWork,
    this.stopWork,
    this.attendance,
    this.isu,
    this.sah,
  });

  String? startWork;
  String? stopWork;
  AttendanceToday? attendance;
  List<dynamic>? isu;
  Sah? sah;

  factory SvData.fromJson(Map<String, dynamic> json) => SvData(
        startWork: json["start_work"] ?? "",
        stopWork: json["stop_work"] ?? "",
        attendance: json["attendance"] != null
            ? AttendanceToday.fromJson(json["attendance"])
            : null,
        isu: List<dynamic>.from(json["isu"].map((x) => x)),
        sah: Sah.fromJson(json["sah"]),
      );

  Map<String, dynamic> toJson() => {
        "start_work": startWork,
        "stop_work": stopWork,
        "attendance": attendance,
        "isu": List<dynamic>.from(isu!.map((x) => x)),
        "sah": sah!.toJson(),
      };
}

class AttendanceToday {
  AttendanceToday({
    required this.clockInAt,
    required this.clockOutAt,
  });

  String clockInAt;
  String clockOutAt;

  factory AttendanceToday.fromJson(Map<String, dynamic> json) =>
      AttendanceToday(
        clockInAt: json["clock_in_at"] ?? "",
        clockOutAt: json["clock_out_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "clock_in_at": clockInAt,
        "clock_out_at": clockOutAt,
      };
}

class Sah {
  Sah({
    this.attendance,
    this.checklist,
    this.leave,
    this.workerRequest,
  });

  List<Attendance>? attendance;
  List<dynamic>? checklist;
  List<Leave>? leave;
  List<dynamic>? workerRequest;

  factory Sah.fromJson(Map<String, dynamic> json) => Sah(
        attendance: List<Attendance>.from(
            json["attendance"].map((x) => Attendance.fromJson(x))),
        checklist: List<dynamic>.from(json["checklist"].map((x) => x)),
        leave: List<Leave>.from(json["leave"].map((x) => Leave.fromJson(x))),
        workerRequest: List<dynamic>.from(json["worker_request"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "attendance": List<dynamic>.from(attendance!.map((x) => x.toJson())),
        "checklist": List<dynamic>.from(checklist!.map((x) => x)),
        "leave": List<dynamic>.from(leave!.map((x) => x.toJson())),
        "worker_request": List<dynamic>.from(workerRequest!.map((x) => x)),
      };
}

class Attendance {
  Attendance({
    this.id,
    this.mainRoute,
    this.vehicleNo,
    this.totalWorker,
    this.workersAttendedCount,
  });

  int? id;
  String? mainRoute;
  String? vehicleNo;
  int? totalWorker;
  int? workersAttendedCount;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        id: json["id"],
        mainRoute: json["main_route"],
        vehicleNo: json["vehicle_no"],
        totalWorker: json["total_worker"],
        workersAttendedCount: json["workers_attended_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main_route": mainRoute,
        "vehicle_no": vehicleNo,
        "total_worker": totalWorker,
        "workers_attended_count": workersAttendedCount,
      };
}

class Leave {
  Leave({
    required this.id,
    required this.userId,
    required this.leaveTypeId,
    required this.dateLeaveFrom,
    required this.dateLeaveTo,
    this.remarks,
  });

  int id;
  UserId userId;
  LeaveTypeId leaveTypeId;
  String? dateLeaveFrom;
  String? dateLeaveTo;
  String? remarks;

  factory Leave.fromJson(Map<String, dynamic> json) => Leave(
        id: json["id"],
        userId: UserId.fromJson(json["user_id"]),
        leaveTypeId: LeaveTypeId.fromJson(json["leave_type_id"]),
        dateLeaveFrom: json["date_leave_from"],
        dateLeaveTo: json["date_leave_to"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId.toJson(),
        "leave_type_id": leaveTypeId.toJson(),
        "date_leave_from": dateLeaveFrom,
        "date_leave_to": dateLeaveTo,
        "remarks": remarks,
      };
}

class LeaveTypeId {
  LeaveTypeId({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory LeaveTypeId.fromJson(Map<String, dynamic> json) => LeaveTypeId(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class UserId {
  UserId({
    this.id,
    this.emsUserId,
    this.contractorUserId,
    required this.userDetail,
  });

  int? id;
  int? emsUserId;
  dynamic contractorUserId;
  UserDetail? userDetail;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"],
        emsUserId: json["ems_user_id"],
        contractorUserId: json["contractor_user_id"],
        userDetail: UserDetail.fromJson(json["user_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
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
        loginId: json["login_id"],
        profilePic: json["profile_pic"],
        email: json["email"],
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
