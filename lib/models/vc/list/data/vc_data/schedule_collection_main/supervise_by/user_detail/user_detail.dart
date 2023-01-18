import 'package:eswm/models/vc/list/data/vc_data/schedule_collection_main/supervise_by/user_detail/supervisor_user/supervisor_user.dart';

class UserDetail {
  UserDetail({
    this.id,
    this.name,
    this.loginId,
    this.profilePic,
    this.email,
    this.supervisorId,
    this.stateId,
    this.stateGeneralId,
    this.supervisorUser,
  });

  int? id;
  String? name;
  String? loginId;
  String? profilePic;
  String? email;
  int? supervisorId;
  int? stateId;
  int? stateGeneralId;
  SupervisorUser? supervisorUser;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        name: json["name"],
        loginId: json["login_id"],
        profilePic: json["profile_pic"],
        email: json["email"],
        supervisorId: json["supervisor_id"],
        stateId: json["state_id"],
        stateGeneralId: json["state_general_id"],
        supervisorUser: SupervisorUser.fromJson(json["supervisor_user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "login_id": loginId,
        "profile_pic": profilePic,
        "email": email,
        "supervisor_id": supervisorId,
        "state_id": stateId,
        "state_general_id": stateGeneralId,
        "supervisor_user": supervisorUser!.toJson(),
      };
}
