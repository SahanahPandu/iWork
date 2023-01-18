import 'data/data.dart';

class VehicleChecklistList {
  VehicleChecklistList({
    this.data,
    this.status,
    this.message,
  });

  Data? data;
  String? status;
  String? message;

  factory VehicleChecklistList.fromJson(Map<String, dynamic> json) =>
      VehicleChecklistList(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "status": status,
        "message": message,
      };
}
