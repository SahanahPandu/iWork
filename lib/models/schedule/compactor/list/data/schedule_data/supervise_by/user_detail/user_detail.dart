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
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        loginId: json["login_id"] ?? "",
        profilePic: json["profile_pic"] ?? "",
        email: json["email"] ?? "",
        supervisorId: json["supervisor_id"] ?? 0,
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
