import 'package:eswm/models/user/user_data.dart';
import 'package:json_annotation/json_annotation.dart';

class ScheduleDetails {
  final int id;
  final String vehicleNo;
  final String mainRoute;
  final String scheduleDate;

  @JsonKey(defaultValue: null)
  final Activity? activityCode;

  @JsonKey(defaultValue: "")
  final String? startScheduleAt;

  @JsonKey(defaultValue: "")
  final String? stopScheduleAt;

  @JsonKey(defaultValue: "")
  final String? startWorkAt;

  @JsonKey(defaultValue: "")
  final String? stopWorkAt;

  @JsonKey(defaultValue: 0)
  final int? totalSubRoute;

  @JsonKey(defaultValue: 0)
  final int? totalPark;

  @JsonKey(defaultValue: 0)
  final int? totalStreet;

  final Status? statusCode;

  @JsonKey(defaultValue: null)
  final VehicleChecklist? vehicleChecklistId;

  @JsonKey(defaultValue: null)
  final UserData? superviseBy;

  ScheduleDetails({
    required this.id,
    required this.vehicleNo,
    required this.mainRoute,
    required this.scheduleDate,
    this.startScheduleAt,
    this.stopScheduleAt,
    required this.activityCode,
    required this.startWorkAt,
    required this.stopWorkAt,
    required this.totalSubRoute,
    required this.totalPark,
    required this.totalStreet,
    required this.statusCode,
    this.vehicleChecklistId,
    this.superviseBy,
  });

  factory ScheduleDetails.fromJson(json) => ScheduleDetails(
        id: json['id'] ?? 0,
        vehicleNo: json['vehicle_no'] ?? "",
        mainRoute: json['main_route'] ?? "",
        scheduleDate: json['schedule_date'] ?? "",
        activityCode: json['activity_code'] != null
            ? Activity.fromJson(json['activity_code'])
            : null,
        startScheduleAt: json['start_schedule_at'] ?? "--:--",
        stopScheduleAt: json['stop_schedule_at'] ?? "--:--",
        startWorkAt: json['start_work_at'] ?? "--:--",
        stopWorkAt: json['stop_work_at'] ?? "--:--",
        totalSubRoute: json['total_sub_route'],
        totalPark: json['total_park'],
        totalStreet: json['total_street'],
        statusCode: json['status_code'] != null
            ? Status.fromJson(json['status_code'])
            : null,
        vehicleChecklistId: json['vehicle_checklist_id'] != null
            ? VehicleChecklist.fromJson(json['vehicle_checklist_id'])
            : null,
        superviseBy: json['supervise_by'] != null
            ? UserData.fromJson(json['supervise_by'])
            : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vehicle_no'] = vehicleNo;
    data['main_route'] = mainRoute;
    data['schedule_date'] = scheduleDate;
    data['activity_code'] = activityCode;
    data['start_work_at'] = startWorkAt;
    data['stop_work_at'] = stopWorkAt;
    data['total_sub_route'] = totalSubRoute;
    data['total_park'] = totalPark;
    data['total_street'] = totalStreet;

    data['status_code'] = statusCode?.toJson();

    data['vehicle_checklist_id'] = vehicleChecklistId?.toJson();

    return data;
  }
}

class Activity {
  final String activityCode;
  final String activityName;

  const Activity({
    required this.activityCode,
    required this.activityName,
  });

  factory Activity.fromJson(json) => Activity(
        activityCode: json['activity_code'],
        activityName: json['activity_name'],
      );
}

class Status {
  final String code;
  final String name;

  const Status({required this.code, required this.name});

  static Status fromJson(json) => Status(
        code: json['code'] ?? "",
        name: json['name'] ?? "",
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}

class VehicleChecklist {
  final int? id;
  final VCStatus? status;

  const VehicleChecklist({this.id, this.status});

  static VehicleChecklist fromJson(json) => VehicleChecklist(
        id: json['id'] ?? 0,
        status: VCStatus.fromJson(json['status_code']),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status!.toJson();

    return data;
  }
}

class VCStatus {
  final String? code;
  final String? name;

  const VCStatus({this.code, this.name});

  static VCStatus fromJson(json) => VCStatus(
        code: json['code'] ?? "",
        name: json['name'] ?? "",
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
