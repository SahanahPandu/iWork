import 'vehicle_checklists/vehicle_checklists.dart';

class Data {
  Data({
    this.vehicleChecklists,
  });

  VehicleChecklists? vehicleChecklists;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        vehicleChecklists:
            VehicleChecklists.fromJson(json["vehicle_checklists"]),
      );

  Map<String, dynamic> toJson() => {
        "vehicle_checklists": vehicleChecklists?.toJson(),
      };
}
