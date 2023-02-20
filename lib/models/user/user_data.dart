import 'package:eswm/models/user/user_roles.dart';
import 'package:json_annotation/json_annotation.dart';

import 'user_details.dart';

@JsonSerializable()
class UserData {
  int id;

  @JsonKey(defaultValue: null)
  int? userTypeId;

  @JsonKey(defaultValue: 0)
  int? emsUserId;

  @JsonKey(defaultValue: null)
  String? vehicleNo;

  @JsonKey(defaultValue: null)
  String? deviceInfo1;

  @JsonKey(defaultValue: null)
  int? isFirstTimeLogin;

  @JsonKey(defaultValue: null)
  String? accessToken;

  @JsonKey(defaultValue: null)
  int? canLogin;

  @JsonKey(defaultValue: null)
  List<UserRole>? userRoles;

  @JsonKey(defaultValue: [])
  UserDetail? userDetail;

  UserData({
    required this.id,
    this.userTypeId,
    this.emsUserId,
    required this.vehicleNo,
    required this.deviceInfo1,
    this.isFirstTimeLogin,
    required this.accessToken,
    this.canLogin,
    this.userRoles,
    this.userDetail,
  });

  factory UserData.fromJson(json) => UserData(
        id: json["id"],
        userTypeId: json["user_type_id"],
        emsUserId: json["ems_user_id"],
        vehicleNo: json["vehicle_no"],
        deviceInfo1: json["device_info_1"],
        isFirstTimeLogin: json["is_first_time_login"],
        accessToken: json["access_token"],
        canLogin: json["can_login"],
        userRoles: json["user_roles"] != null
            ? List<UserRole>.from(json["user_roles"].map((x) => x))
            : [],
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
        "roles": userRoles ?? List<UserRole>.from(userRoles!.map((x) => x)),
        "user_detail": userDetail?.toJson(),
      };
}
