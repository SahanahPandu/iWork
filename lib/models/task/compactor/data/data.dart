import 'package:eswm/models/task/compactor/data/schedule/schedule.dart';
import 'package:eswm/models/task/compactor/data/schedule/vehicle_checklist_id/vehicle_checklist_id.dart';

class Data {
  Data({
    this.startWork,
    this.stopWork,
    this.vehicleChecklistId,
    this.schedules,
  });

  String? startWork;
  String? stopWork;
  VehicleChecklistId? vehicleChecklistId;
  List<Schedule>? schedules;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        startWork: json["start_work"] ?? "--:--",
        stopWork: json["stop_work"] ?? "--:--",
        vehicleChecklistId: json["vehicle_checklist_id"] != null
            ? VehicleChecklistId.fromJson(json["vehicle_checklist_id"])
            : null,
        schedules: List<Schedule>.from(
            json["schedules"].map((x) => Schedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "schedules": List<dynamic>.from(schedules!.map((x) => x.toJson())),
      };
}
