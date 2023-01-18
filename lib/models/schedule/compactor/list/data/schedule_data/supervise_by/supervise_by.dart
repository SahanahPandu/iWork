import 'package:eswm/models/schedule/compactor/list/data/schedule_data/supervise_by/user_detail/user_detail.dart';

class SuperviseBy {
  SuperviseBy({
    this.id,
    this.emsUserId,
    this.userDetail,
  });

  int? id;
  int? emsUserId;
  UserDetail? userDetail;

  factory SuperviseBy.fromJson(Map<String, dynamic> json) => SuperviseBy(
        id: json["id"] ?? "",
        emsUserId: json["ems_user_id"] ?? "",
        userDetail: json["user_detail"] != null? UserDetail.fromJson(json["user_detail"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ems_user_id": emsUserId,
        "user_detail": userDetail!.toJson(),
      };
}
