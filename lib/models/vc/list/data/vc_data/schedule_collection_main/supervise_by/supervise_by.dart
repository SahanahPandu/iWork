import 'package:eswm/models/vc/list/data/vc_data/schedule_collection_main/supervise_by/user_detail/user_detail.dart';

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
        id: json["id"],
        emsUserId: json["ems_user_id"],
        userDetail: UserDetail.fromJson(json["user_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ems_user_id": emsUserId,
        "user_detail": userDetail!.toJson(),
      };
}
