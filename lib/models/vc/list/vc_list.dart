import 'data/vc_data.dart';

class VehicleChecklistList {
  VehicleChecklistList({
    this.data,
    this.status,
    this.message,
  });

  VCData? data;
  String? status;
  String? message;

  factory VehicleChecklistList.fromJson(Map<String, dynamic> json) =>
      VehicleChecklistList(
        data: json["data"] != null ? VCData.fromJson(json["data"]) : null,
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "status": status,
        "message": message,
      };
}
