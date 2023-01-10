import 'package:eswm/models/task/compactor/data/schedule/schedule.dart';
import 'package:eswm/models/task/compactor/data/schedule/vehicle_checklist_id/vehicle_checklist_id.dart';

import 'workers/workers.dart';

class Data {
  Data({
    this.startWork,
    this.stopWork,
    this.workers,
    this.vehicleChecklistId,
    this.schedules,
  });

  String? startWork;
  String? stopWork;
  List<Worker?>? workers;
  VehicleChecklistId? vehicleChecklistId;
  List<Schedule>? schedules;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        startWork: json["start_work"] ?? "--:--",
        stopWork: json["stop_work"] ?? "--:--",
        workers: json["workers"] == null
            ? []
            : List<Worker?>.from(
                json["workers"]!.map((x) => Worker.fromJson(x))),
        vehicleChecklistId: json["vehicle_checklist_id"] != null
            ? VehicleChecklistId.fromJson(json["vehicle_checklist_id"])
            : null,
        schedules: List<Schedule>.from(
            json["schedules"].map((x) => Schedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "start_work": startWork,
        "stop_work": stopWork,
        "workers": workers == null
            ? []
            : List<dynamic>.from(workers!.map((x) => x!.toJson())),
        "vehicle_checklist_id": vehicleChecklistId,
        "schedules": schedules == null
            ? []
            : List<dynamic>.from(schedules!.map((x) => x.toJson())),
      };
}
