import 'package:eswm/models/task/compactor/data/schedules/status_code/status_code.dart';

import 'activity_code/activity_code.dart';

class Schedule {
  Schedule({
    required this.id,
    required this.vehicleNo,
    required this.mainRoute,
    required this.scheduleDate,
    required this.statusCode,
    required this.totalSubRoute,
    required this.totalPark,
    required this.totalStreet,
    this.startWorkAt,
    this.stopWorkAt,
    this.vehicleChecklistId,
    required this.activityCode,
    required this.workerSchedules,
  });

  int id;
  String vehicleNo;
  String mainRoute;
  DateTime scheduleDate;
  StatusCode statusCode;
  int totalSubRoute;
  int totalPark;
  int totalStreet;
  String? startWorkAt;
  String? stopWorkAt;
  dynamic vehicleChecklistId;
  ActivityCode activityCode;
  List<dynamic> workerSchedules;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        vehicleNo: json["vehicle_no"],
        mainRoute: json["main_route"],
        scheduleDate: DateTime.parse(json["schedule_date"]),
        statusCode: StatusCode.fromJson(json["status_code"]),
        totalSubRoute: json["total_sub_route"],
        totalPark: json["total_park"],
        totalStreet: json["total_street"],
        startWorkAt: json["start_work_at"],
        stopWorkAt: json["stop_work_at"],
        vehicleChecklistId: json["vehicle_checklist_id"],
        activityCode: ActivityCode.fromJson(json["activity_code"]),
        workerSchedules:
            List<dynamic>.from(json["worker_schedules"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle_no": vehicleNo,
        "main_route": mainRoute,
        "schedule_date":
            "${scheduleDate.year.toString().padLeft(4, '0')}-${scheduleDate.month.toString().padLeft(2, '0')}-${scheduleDate.day.toString().padLeft(2, '0')}",
        "status_code": statusCode.toJson(),
        "total_sub_route": totalSubRoute,
        "total_park": totalPark,
        "total_street": totalStreet,
        "start_work_at": startWorkAt,
        "stop_work_at": stopWorkAt,
        "vehicle_checklist_id": vehicleChecklistId,
        "activity_code": activityCode.toJson(),
        "worker_schedules": List<dynamic>.from(workerSchedules.map((x) => x)),
      };
}
