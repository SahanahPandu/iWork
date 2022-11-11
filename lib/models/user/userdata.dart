class UserData {
  UserData({
    required this.id,
    required this.userTypeId,
    required this.vehicleNo,
    required this.deviceInfo1,
    required this.isFirstTimeLogin,
    required this.accessToken,
    required this.canLogin,
    required this.roles,
    this.userDetail,
  });

  int id;
  int userTypeId;
  String vehicleNo;
  String deviceInfo1;
  int isFirstTimeLogin;
  String accessToken;
  int canLogin;
  List<dynamic> roles;
  dynamic userDetail;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        userTypeId: json["user_type_id"],
        vehicleNo: json["vehicle_no"],
        deviceInfo1: json["device_info_1"],
        isFirstTimeLogin: json["is_first_time_login"],
        accessToken: json["access_token"],
        canLogin: json["can_login"],
        roles: List<dynamic>.from(json["roles"].map((x) => x)),
        userDetail: json["user_detail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_type_id": userTypeId,
        "vehicle_no": vehicleNo,
        "device_info_1": deviceInfo1,
        "is_first_time_login": isFirstTimeLogin,
        "access_token": accessToken,
        "can_login": canLogin,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "user_detail": userDetail,
      };
}
