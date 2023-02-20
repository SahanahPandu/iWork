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
        status: json["status"] ?? "",
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class SvData {
  SvData({
    this.scheduleDate,
    this.startWork,
    this.stopWork,
    this.attendance,
    this.isu,
    this.sah,
  });

  String? scheduleDate;
  String? startWork;
  String? stopWork;
  AttendanceToday? attendance;
  List<Isu>? isu;
  Sah? sah;

  factory SvData.fromJson(Map<String, dynamic> json) => SvData(
        scheduleDate: json["schedule_date"] ?? "",
        startWork: json["start_work"] ?? "",
        stopWork: json["stop_work"] ?? "",
        attendance: json["attendance"] != null
            ? AttendanceToday.fromJson(json["attendance"])
            : null,
        isu: json["isu"] != null
            ? List<Isu>.from(json["isu"].map((x) => Isu.fromJson(x)))
            : [],
        sah: Sah.fromJson(json["sah"]),
      );

  Map<String, dynamic> toJson() => {
        "schedule_date": scheduleDate,
        "start_work": startWork,
        "stop_work": stopWork,
        "attendance": attendance,
        "isu": List<dynamic>.from(isu!.map((x) => x)),
        "sah": sah!.toJson(),
      };
}

class Isu {
  Isu({
    required this.scMainId,
    required this.mainRoute,
    required this.vehicleNo,
    this.scheduleDate,
    required this.tabGroupSv,
    required this.tabSubGroupSv,
    required this.totalSubRoute,
    required this.totalPark,
    required this.totalStreet,
    required this.superviseBy,
    required this.statusCode,
  });

  int scMainId;
  String mainRoute;
  String vehicleNo;
  String? scheduleDate;
  String tabGroupSv;
  StatusCode tabSubGroupSv;
  int totalSubRoute;
  int totalPark;
  int totalStreet;
  SuperviseBy superviseBy;
  StatusCode statusCode;

  factory Isu.fromJson(Map<String, dynamic> json) => Isu(
        scMainId: json["sc_main_id"],
        mainRoute: json["main_route"],
        vehicleNo: json["vehicle_no"],
        scheduleDate: json["schedule_date"] ?? "--:--",
        tabGroupSv: json["tab_group_sv"],
        tabSubGroupSv: StatusCode.fromJson(json["tab_sub_group_sv"]),
        totalSubRoute: json["total_sub_route"],
        totalPark: json["total_park"],
        totalStreet: json["total_street"],
        superviseBy: SuperviseBy.fromJson(json["supervise_by"]),
        statusCode: StatusCode.fromJson(json["status_code"]),
      );

  Map<String, dynamic> toJson() => {
        "sc_main_id": scMainId,
        "main_route": mainRoute,
        "vehicle_no": vehicleNo,
        "tab_group_sv": tabGroupSv,
        "tab_sub_group_sv": tabSubGroupSv.toJson(),
        "total_sub_route": totalSubRoute,
        "total_park": totalPark,
        "total_street": totalStreet,
        "supervise_by": superviseBy.toJson(),
        "status_code": statusCode.toJson(),
      };
}

class StatusCode {
  StatusCode({
    required this.code,
    required this.name,
  });

  String code;
  String name;

  factory StatusCode.fromJson(Map<String, dynamic> json) => StatusCode(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}

class SuperviseBy {
  SuperviseBy({
    required this.id,
    required this.emsUserId,
    required this.userDetail,
  });

  int id;
  int emsUserId;
  UserDetail userDetail;

  factory SuperviseBy.fromJson(Map<String, dynamic> json) => SuperviseBy(
        id: json["id"],
        emsUserId: json["ems_user_id"],
        userDetail: UserDetail.fromJson(json["user_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ems_user_id": emsUserId,
        "user_detail": userDetail.toJson(),
      };
}

class UserDetail {
  UserDetail({
    required this.id,
    required this.name,
    required this.loginId,
    required this.profilePic,
    this.email,
    required this.supervisorId,
  });

  int id;
  String name;
  String loginId;
  String profilePic;
  String? email;
  int supervisorId;

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
  List<Checklist>? checklist;
  List<Leave>? leave;
  List<WorkerRequest>? workerRequest;

  factory Sah.fromJson(Map<String, dynamic> json) => Sah(
        attendance: json["attendance"] != null
            ? List<Attendance>.from(
                json["attendance"].map((x) => Attendance.fromJson(x)))
            : [],
        checklist: json["checklist"] != null
            ? List<Checklist>.from(
                json["checklist"].map((x) => Checklist.fromJson(x)))
            : [],
        leave: json["leave"] != null
            ? List<Leave>.from(json["leave"].map((x) => Leave.fromJson(x)))
            : [],
        workerRequest: List<WorkerRequest>.from(
            json["worker_request"].map((x) => WorkerRequest.fromJson(x))),
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

class Checklist {
  Checklist({
    required this.id,
    required this.mainRoute,
    required this.vehicleNo,
    required this.vehicleChecklistId,
  });

  int id;
  String mainRoute;
  String vehicleNo;
  VehicleChecklistId vehicleChecklistId;

  factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
        id: json["id"],
        mainRoute: json["main_route"],
        vehicleNo: json["vehicle_no"],
        vehicleChecklistId:
            VehicleChecklistId.fromJson(json["vehicle_checklist_id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main_route": mainRoute,
        "vehicle_no": vehicleNo,
        "vehicle_checklist_id": vehicleChecklistId.toJson(),
      };
}

class VehicleChecklistId {
  VehicleChecklistId({
    required this.id,
    required this.statusCode,
  });

  int id;
  StatusCode? statusCode;

  factory VehicleChecklistId.fromJson(Map<String, dynamic> json) =>
      VehicleChecklistId(
        id: json["id"],
        statusCode: json["status_code"] != null
            ? StatusCode.fromJson(json["status_code"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status_code": statusCode!.toJson(),
      };
}

class WorkerRequest {
  WorkerRequest({
    required this.id,
    required this.scMainId,
    required this.userId,
    required this.reassignWithUserId,
    required this.updatedAt,
  });

  int id;
  ScMainId scMainId;
  UserId userId;
  UserId reassignWithUserId;
  String updatedAt;

  factory WorkerRequest.fromJson(Map<String, dynamic> json) => WorkerRequest(
        id: json["id"],
        scMainId: ScMainId.fromJson(json["sc_main_id"]),
        userId: UserId.fromJson(json["user_id"]),
        reassignWithUserId: UserId.fromJson(json["reassign_with_user_id"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sc_main_id": scMainId.toJson(),
        "user_id": userId.toJson(),
        "reassign_with_user_id": reassignWithUserId.toJson(),
        "updated_at": updatedAt,
      };
}

class UserRole {
  UserRole({
    required this.id,
    required this.userId,
    required this.roleCode,
    required this.roleDesc,
  });

  int id;
  int userId;
  String roleCode;
  String roleDesc;

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        id: json["id"],
        userId: json["user_id"],
        roleCode: json["role_code"],
        roleDesc: json["role_desc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "role_code": roleCode,
        "role_desc": roleDesc,
      };
}

class ScMainId {
  ScMainId({
    required this.id,
    required this.scheduleDate,
    required this.mainRoute,
    required this.superviseBy,
  });

  int id;
  DateTime scheduleDate;
  String mainRoute;
  SuperviseBy superviseBy;

  factory ScMainId.fromJson(Map<String, dynamic> json) => ScMainId(
        id: json["id"],
        scheduleDate: DateTime.parse(json["schedule_date"]),
        mainRoute: json["main_route"],
        superviseBy: SuperviseBy.fromJson(json["supervise_by"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "schedule_date":
            "${scheduleDate.year.toString().padLeft(4, '0')}-${scheduleDate.month.toString().padLeft(2, '0')}-${scheduleDate.day.toString().padLeft(2, '0')}",
        "main_route": mainRoute,
        "supervise_by": superviseBy.toJson(),
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
