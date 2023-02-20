// To parse this JSON data, do
//
//     final requestWorker = requestWorkerFromJson(jsonString);

import 'dart:convert';

RequestWorker requestWorkerFromJson(String str) =>
    RequestWorker.fromJson(json.decode(str));

String requestWorkerToJson(RequestWorker data) => json.encode(data.toJson());

class RequestWorker {
  RequestWorker({
    required this.data,
    required this.status,
    required this.message,
  });

  Data data;
  String status;
  String message;

  factory RequestWorker.fromJson(Map<String, dynamic> json) => RequestWorker(
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
    required this.workerRequest,
  });

  List<WorkerRequest> workerRequest;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        workerRequest: List<WorkerRequest>.from(
            json["worker_request"].map((x) => WorkerRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "worker_request":
            List<dynamic>.from(workerRequest.map((x) => x.toJson())),
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
  DateTime updatedAt;

  factory WorkerRequest.fromJson(Map<String, dynamic> json) => WorkerRequest(
        id: json["id"],
        scMainId: ScMainId.fromJson(json["sc_main_id"]),
        userId: UserId.fromJson(json["user_id"]),
        reassignWithUserId: UserId.fromJson(json["reassign_with_user_id"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sc_main_id": scMainId.toJson(),
        "user_id": userId.toJson(),
        "reassign_with_user_id": reassignWithUserId.toJson(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UserId {
  UserId({
    required this.id,
    required this.emsUserId,
    this.contractorUserId,
    required this.userDetail,
    this.userRoles,
  });

  int id;
  int emsUserId;
  dynamic contractorUserId;
  UserDetail userDetail;
  List<UserRole>? userRoles;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"],
        emsUserId: json["ems_user_id"],
        contractorUserId: json["contractor_user_id"],
        userDetail: UserDetail.fromJson(json["user_detail"]),
        userRoles: json["user_roles"] == null
            ? []
            : List<UserRole>.from(
                json["user_roles"]!.map((x) => UserRole.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ems_user_id": emsUserId,
        "contractor_user_id": contractorUserId,
        "user_detail": userDetail.toJson(),
        "user_roles": userRoles == null
            ? []
            : List<dynamic>.from(userRoles!.map((x) => x.toJson())),
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
  String scheduleDate;
  String mainRoute;
  SuperviseBy superviseBy;

  factory ScMainId.fromJson(Map<String, dynamic> json) => ScMainId(
        id: json["id"],
        scheduleDate: json["schedule_date"],
        mainRoute: json["main_route"],
        superviseBy: SuperviseBy.fromJson(json["supervise_by"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "schedule_date": scheduleDate,
        "main_route": mainRoute,
        "supervise_by": superviseBy.toJson(),
      };
}

class SuperviseBy {
  SuperviseBy({
    required this.id,
    required this.emsUserId,
    this.contractorUserId,
    required this.userDetail,
  });

  int id;
  int emsUserId;
  dynamic contractorUserId;
  UserDetail userDetail;

  factory SuperviseBy.fromJson(Map<String, dynamic> json) => SuperviseBy(
        id: json["id"],
        emsUserId: json["ems_user_id"],
        contractorUserId: json["contractor_user_id"],
        userDetail: UserDetail.fromJson(json["user_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ems_user_id": emsUserId,
        "contractor_user_id": contractorUserId,
        "user_detail": userDetail.toJson(),
      };
}
