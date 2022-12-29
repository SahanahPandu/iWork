import 'package:eswm/models/task/compactor/data/schedule/vehicle_checklist_id/status_code/status_code.dart';

class VehicleChecklistId {
  VehicleChecklistId({
    this.id,
    this.vehicleNo,
    this.statusCode,
    this.timeIn,
    this.timeOut,
  });

  int? id;
  String? vehicleNo;
  StatusCode? statusCode;
  String? timeIn;
  String? timeOut;

  factory VehicleChecklistId.fromJson(Map<String, dynamic> json) =>
      VehicleChecklistId(
        id: json["id"],
        vehicleNo: json["vehicle_no"],
        statusCode: StatusCode.fromJson(json["status_code"]),
        timeIn: json["time_in"] ?? "--:--",
        timeOut: json["time_out"] ?? "--:--",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle_no": vehicleNo,
        "status_code": statusCode!.toJson(),
        "time_in": timeIn,
        "time_out": timeOut,
      };
}
