import '../schedule/status_code/status_code.dart';
import '../schedule/vehicle_checklist_id/vehicle_checklist_id.dart';
import 'activity_code/activity_code.dart';
import 'worker_schedule/worker_schedule.dart';

class Schedule {
  Schedule({
    this.id,
    this.vehicleNo,
    this.mainRoute,
    this.scheduleDate,
    this.statusCode,
    this.totalSubRoute,
    this.totalPark,
    this.totalStreet,
    this.startScheduleAt,
    this.stopScheduleAt,
    this.startWorkAt,
    this.stopWorkAt,
    this.vehicleChecklistId,
    this.activityCode,
    this.workerSchedules,
  });

  int? id;
  String? vehicleNo;
  String? mainRoute;
  String? scheduleDate;
  StatusCode? statusCode;
  int? totalSubRoute;
  int? totalPark;
  int? totalStreet;
  String? startScheduleAt;
  String? stopScheduleAt;
  String? startWorkAt;
  String? stopWorkAt;
  VehicleChecklistId? vehicleChecklistId;
  ActivityCode? activityCode;
  List<WorkerSchedule>? workerSchedules;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        vehicleNo: json["vehicle_no"],
        mainRoute: json["main_route"],
        scheduleDate: json["schedule_date"],
        statusCode: json["status_code"] != null
            ? StatusCode.fromJson(json["status_code"])
            : null,
        totalSubRoute: json["total_sub_route"],
        totalPark: json["total_park"],
        totalStreet: json["total_street"],
        startScheduleAt: json["start_schedule_at"] ?? "--:--",
        stopScheduleAt: json["stop_schedule_at"] ?? "--:--",
        startWorkAt: json["start_work_at"] ?? "--:--",
        stopWorkAt: json["stop_work_at"] ?? "--:--",
        vehicleChecklistId: json["vehicle_checklist_id"] != null
            ? VehicleChecklistId.fromJson(json["vehicle_checklist_id"])
            : null,
        activityCode: ActivityCode.fromJson(json["activity_code"]),
        workerSchedules: json["worker_schedules"] == null
            ? []
            : List<WorkerSchedule>.from(
                json["worker_schedules"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle_no": vehicleNo,
        "main_route": mainRoute,
        "schedule_date": scheduleDate,
        "status_code": statusCode!.toJson(),
        "total_sub_route": totalSubRoute,
        "total_park": totalPark,
        "total_street": totalStreet,
        "start_schedule_at": startScheduleAt,
        "stop_schedule_at": stopScheduleAt,
        "start_work_at": startWorkAt,
        "stop_work_at": stopWorkAt,
        "vehicle_checklist_id": vehicleChecklistId!.toJson(),
        "activity_code": activityCode!.toJson(),
        "worker_schedules": workerSchedules == null
            ? []
            : List<WorkerSchedule>.from(workerSchedules!.map((x) => x)),
      };
}
