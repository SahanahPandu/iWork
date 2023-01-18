class CScheduleDetail {
  CScheduleDetail({
    this.data,
    this.status,
    this.message,
  });

  Data? data;
  String? status;
  dynamic message;

  factory CScheduleDetail.fromJson(Map<String, dynamic> json) =>
      CScheduleDetail(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "status": status,
        "message": message,
      };
}

class Data {
  Data({
    this.details,
  });

  Details? details;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        details: Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "details": details!.toJson(),
      };
}

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
    this.workers,
  });

  int? id;
  String? vehicleNo;
  String? mainRoute;
  DateTime? scheduleDate;
  ActivityCode? activityCode;
  String? startScheduleAt;
  String? stopScheduleAt;
  dynamic startWorkAt;
  dynamic stopWorkAt;
  int? totalSubRoute;
  int? totalPark;
  int? totalStreet;
  StatusCode? statusCode;
  VehicleChecklistId? vehicleChecklistId;
  List<Worker?>? workers;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        vehicleNo: json["vehicle_no"],
        mainRoute: json["main_route"],
        scheduleDate: DateTime.parse(json["schedule_date"]),
        activityCode: ActivityCode.fromJson(json["activity_code"]),
        startScheduleAt: json["start_schedule_at"],
        stopScheduleAt: json["stop_schedule_at"],
        startWorkAt: json["start_work_at"],
        stopWorkAt: json["stop_work_at"],
        totalSubRoute: json["total_sub_route"],
        totalPark: json["total_park"],
        totalStreet: json["total_street"],
        statusCode: StatusCode.fromJson(json["status_code"]),
        vehicleChecklistId: json["vehicle_checklist_id"] != null
            ? VehicleChecklistId.fromJson(json["vehicle_checklist_id"])
            : null,
        workers: json["workers"] == null
            ? []
            : List<Worker?>.from(
                json["workers"]!.map((x) => Worker.fromJson(x))),
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
        "workers": workers == null
            ? []
            : List<dynamic>.from(workers!.map((x) => x!.toJson())),
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

class Worker {
  Worker({
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
  List<UserRole?>? userRoles;

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        id: json["id"],
        userTypeId: json["user_type_id"],
        emsUserId: json["ems_user_id"],
        contractorUserId: json["contractor_user_id"],
        userDetail: UserDetail.fromJson(json["user_detail"]),
        userRoles: json["user_roles"] == null
            ? []
            : List<UserRole?>.from(
                json["user_roles"]!.map((x) => UserRole.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_type_id": userTypeId,
        "ems_user_id": emsUserId,
        "contractor_user_id": contractorUserId,
        "user_detail": userDetail!.toJson(),
        "user_roles": userRoles == null
            ? []
            : List<dynamic>.from(userRoles!.map((x) => x!.toJson())),
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

class UserRole {
  UserRole({
    this.id,
    this.userId,
    this.roleCode,
    this.roleDesc,
  });

  int? id;
  int? userId;
  String? roleCode;
  String? roleDesc;

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
