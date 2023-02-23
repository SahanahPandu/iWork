import 'dart:convert';

import 'package:eswm/models/task/compactor/data/schedule/vehicle_checklist_id/vehicle_checklist_id.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../task/compactor/data/schedule/status_code/status_code.dart';
import 'supervise_by/supervise_by.dart';

List<CScheduleData> itemFromJson(String str) => List<CScheduleData>.from(
    json.decode(str).map((x) => CScheduleData.fromJson(x)));

class CScheduleData {
  CScheduleData({
    this.id,
    this.mainRoute,
    this.scheduleDate,
    this.startScheduleAt,
    this.stopScheduleAt,
    this.startWorkAt,
    this.stopWorkAt,
    this.statusCode,
    this.vehicleNo,
    this.vehicleChecklistId,
    this.tabGroupSv,
    this.tabSubGroupSv,
    this.totalSubRoute,
    this.totalPark,
    this.totalStreet,
    this.superviseBy,
  });

  int? id;
  String? mainRoute;
  String? scheduleDate;
  String? startScheduleAt;
  String? stopScheduleAt;
  String? startWorkAt;
  String? stopWorkAt;
  StatusCode? statusCode;
  String? vehicleNo;
  VehicleChecklistId? vehicleChecklistId;

  @JsonKey(defaultValue: "")
  String? tabGroupSv;

  @JsonKey(defaultValue: null)
  StatusCode? tabSubGroupSv;

  int? totalSubRoute;
  int? totalPark;
  int? totalStreet;
  SuperviseBy? superviseBy;

  factory CScheduleData.fromJson(Map<String, dynamic> json) => CScheduleData(
        id: json["id"],
        mainRoute: json["main_route"],
        scheduleDate: json["schedule_date"],
        startScheduleAt: json["start_schedule_at"] ?? "--:--",
        stopScheduleAt: json["stop_schedule_at"] ?? "--:--",
        startWorkAt: json["start_work_at"] ?? "--:--",
        stopWorkAt: json["stop_work_at"] ?? "--:--",
        statusCode: StatusCode.fromJson(json["status_code"]),
        vehicleNo: json["vehicle_no"],
        vehicleChecklistId: json["vehicle_checklist_id"] == null
            ? null
            : VehicleChecklistId.fromJson(json["vehicle_checklist_id"]),
        tabGroupSv: json["tab_group_sv"] ?? "",
        tabSubGroupSv: json["tab_sub_group_sv"] != null
            ? StatusCode.fromJson(json["tab_sub_group_sv"])
            : null,
        totalSubRoute: json["total_sub_route"],
        totalPark: json["total_park"],
        totalStreet: json["total_street"],
        superviseBy: json["supervise_by"] != null
            ? SuperviseBy.fromJson(json["supervise_by"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main_route": mainRoute,
        "schedule_date": scheduleDate,
        "start_schedule_at": startScheduleAt,
        "stop_schedule_at": stopScheduleAt,
        "start_work_at": startWorkAt,
        "stop_work_at": stopWorkAt,
        "status_code": statusCode!.toJson(),
        "vehicle_no": vehicleNo,
        "vehicle_checklist_id": vehicleChecklistId,
        "tab_group_sv": tabGroupSv,
        "tab_sub_group_sv": tabSubGroupSv!.toJson(),
        "total_sub_route": totalSubRoute,
        "total_park": totalPark,
        "total_street": totalStreet,
        "supervise_by": superviseBy!.toJson(),
      };
}
