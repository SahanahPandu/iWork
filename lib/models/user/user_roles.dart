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

  factory UserRole.fromJson(json) => UserRole(
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
