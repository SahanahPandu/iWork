import 'user_detail/user_detail.dart';

class UserId {
  UserId({
    this.id,
    this.userTypeId,
    this.emsUserId,
    this.contractorUserId,
    this.userDetail,
  });

  int? id;
  int? userTypeId;
  int? emsUserId;
  String? contractorUserId;
  UserDetail? userDetail;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"],
        userTypeId: json["user_type_id"],
        emsUserId: json["ems_user_id"],
        contractorUserId: json["contractor_user_id"],
        userDetail: UserDetail.fromJson(json["user_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_type_id": userTypeId,
        "ems_user_id": emsUserId,
        "contractor_user_id": contractorUserId,
        "user_detail": userDetail!.toJson(),
      };
}
