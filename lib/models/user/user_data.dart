import 'user_details.dart';

class UserData {
  UserData({
    required this.id,
    required this.userTypeId,
    this.emsUserId = 0,
    this.vehicleNo = '',
    required this.deviceInfo1,
    required this.isFirstTimeLogin,
    this.accessToken,
    required this.canLogin,
    required this.roles,
    this.userDetail,
  });

  int id;
  int userTypeId;
  int? emsUserId;
  String? vehicleNo;
  String deviceInfo1;
  int isFirstTimeLogin;
  String? accessToken;
  int canLogin;
  List<dynamic> roles;
  UserDetail? userDetail;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        userTypeId: json["user_type_id"],
        emsUserId: json["ems_user_id"],
        vehicleNo: json["vehicle_no"],
        deviceInfo1: json["device_info_1"],
        isFirstTimeLogin: json["is_first_time_login"],
        accessToken: json["access_token"],
        canLogin: json["can_login"],
        roles: List<dynamic>.from(json["roles"].map((x) => x)),
        userDetail: json["user_detail"] != null
            ? UserDetail?.fromJson(json["user_detail"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_type_id": userTypeId,
        "ems_user_id": emsUserId,
        "vehicle_no": vehicleNo,
        "device_info_1": deviceInfo1,
        "is_first_time_login": isFirstTimeLogin,
        "access_token": accessToken,
        "can_login": canLogin,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "user_detail": userDetail?.toJson(),
      };
}
