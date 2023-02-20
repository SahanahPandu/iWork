class WorkerAttendanceVerification {
  WorkerAttendanceVerification({
    required this.data,
    required this.status,
    this.message,
  });

  Data data;
  String status;
  dynamic message;

  factory WorkerAttendanceVerification.fromJson(Map<String, dynamic> json) =>
      WorkerAttendanceVerification(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class Data {
  Data({
    this.workersAttend,
    this.workersNotAttend,
  });

  List<WorkersAttend>? workersAttend;
  List<WorkersAttend>? workersNotAttend;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        workersAttend: json["workers_attend"] != null
            ? List<WorkersAttend>.from(
                json["workers_attend"].map((x) => WorkersAttend.fromJson(x)))
            : [],
        workersNotAttend: json["workers_not_attend"] != null
            ? List<WorkersAttend>.from(json["workers_not_attend"]
                .map((x) => WorkersAttend.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "workers_attend":
            List<dynamic>.from(workersAttend!.map((x) => x.toJson())),
        "workers_not_attend":
            List<dynamic>.from(workersNotAttend!.map((x) => x.toJson())),
      };
}

class WorkersAttend {
  WorkersAttend({
    required this.id,
    required this.userId,
    this.userAttendanceId,
  });

  int id;
  UserId userId;
  UserAttendanceId? userAttendanceId;

  factory WorkersAttend.fromJson(Map<String, dynamic> json) => WorkersAttend(
        id: json["id"],
        userId: UserId.fromJson(json["user_id"]),
        userAttendanceId: json["user_attendance_id"] == null
            ? null
            : UserAttendanceId.fromJson(json["user_attendance_id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId.toJson(),
        "user_attendance_id": userAttendanceId?.toJson(),
      };
}

class UserAttendanceId {
  UserAttendanceId({
    required this.id,
    required this.userId,
    this.clockInAt,
    this.clockOutAt,
  });

  int id;
  int userId;
  String? clockInAt;
  String? clockOutAt;

  factory UserAttendanceId.fromJson(Map<String, dynamic> json) =>
      UserAttendanceId(
        id: json["id"],
        userId: json["user_id"],
        clockInAt: json["clock_in_at"] ?? "--:--",
        clockOutAt: json["clock_out_at"] ?? "--:--",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "clock_in_at": clockInAt,
        "clock_out_at": clockOutAt,
      };
}

class UserId {
  UserId({
    required this.id,
    required this.emsUserId,
    this.contractorUserId,
    required this.userDetail,
    required this.userRoles,
  });

  int id;
  int emsUserId;
  dynamic contractorUserId;
  UserDetail userDetail;
  List<UserRole> userRoles;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"],
        emsUserId: json["ems_user_id"],
        contractorUserId: json["contractor_user_id"],
        userDetail: UserDetail.fromJson(json["user_detail"]),
        userRoles: List<UserRole>.from(
            json["user_roles"].map((x) => UserRole.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ems_user_id": emsUserId,
        "contractor_user_id": contractorUserId,
        "user_detail": userDetail.toJson(),
        "user_roles": List<dynamic>.from(userRoles.map((x) => x.toJson())),
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
  dynamic email;
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
