import 'dart:convert';

import 'data/data.dart';

VehicleChecklistMain vehicleChecklistMainFromJson(String str) =>
    VehicleChecklistMain.fromJson(json.decode(str));

String vehicleChecklistMainToJson(VehicleChecklistMain data) =>
    json.encode(data.toJson());

class VehicleChecklistMain {
  VehicleChecklistMain({
    this.data,
    required this.status,
    this.message,
  });

  Data? data;
  String status;
  String? message;

  factory VehicleChecklistMain.fromJson(Map<String, dynamic> json) =>
      VehicleChecklistMain(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
        "message": message,
      };
}
