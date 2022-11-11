import 'userdata.dart';

class Data {
  Data({
    required this.userData,
  });

  UserData userData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userData: UserData.fromJson(json["user_data"]),
      );

  Map<String, dynamic> toJson() => {
        "user_data": userData.toJson(),
      };
}
