import '../user_detail/user_detail.dart';
import '../user_roles/user_roles.dart';

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
  int? contractorUserId;
  UserDetail? userDetail;
  List<UserRole>? userRoles;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"],
        userTypeId: json["user_type_id"],
        emsUserId: json["ems_user_id"],
        contractorUserId: json["contractor_user_id"] ?? 0,
        userDetail: json["user_detail"] != null
            ? UserDetail.fromJson(json["user_detail"])
            : null,
        userRoles: json["user_roles"] != null
            ? List<UserRole>.from(
                json["user_roles"]!.map((x) => UserRole.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_type_id": userTypeId,
        "ems_user_id": emsUserId,
        "contractor_user_id": contractorUserId,
        "user_detail": userDetail!.toJson(),
        "user_roles": userRoles == null
            ? []
            : List<dynamic>.from(userRoles!.map((x) => x.toJson())),
      };
}
