import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserDetail {
  int id;
  String name;

  @JsonKey(defaultValue: null)
  String? loginId;

  @JsonKey(defaultValue: null)
  String? profilePic;

  @JsonKey(defaultValue: null)
  dynamic email;

  @JsonKey(defaultValue: null)
  int? supervisorId;

  @JsonKey(defaultValue: null)
  int? stateId;

  @JsonKey(defaultValue: null)
  int? stateGeneralId;

  @JsonKey(defaultValue: null)
  UserDetail? svUser;

  UserDetail({
    required this.id,
    required this.name,
    this.loginId = '',
    this.profilePic = '',
    this.email = '',
    this.supervisorId = 0,
    this.stateId,
    this.stateGeneralId,
    this.svUser,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        name: json["name"],
        loginId: json["login_id"],
        profilePic: json["profile_pic"],
        email: json["email"],
        supervisorId: json["supervisor_id"],
        stateId: json['state_id'],
        stateGeneralId: json['state_general_id'],
        svUser: json["supervisor_user"] != null
            ? UserDetail?.fromJson(json["supervisor_user"])
            : null,
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
