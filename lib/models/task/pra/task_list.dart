import 'package:json_annotation/json_annotation.dart';

class TaskList {
  final int id;
  final String vehicleNo;
  final String mainRoute;
  final String scheduleDate;
  final int totalSubRoute;
  final int totalPark;
  final int totalStreet;

  @JsonKey(defaultValue: "")
  final String? startWorkAt;

  @JsonKey(defaultValue: "")
  final String? stopWorkAt;

  @JsonKey(defaultValue: "")
  final String? startSchedule;

  @JsonKey(defaultValue: "")
  final String? stopSchedule;

  final Status statusCode;

  const TaskList({
    required this.id,
    required this.vehicleNo,
    required this.mainRoute,
    required this.scheduleDate,
    required this.totalSubRoute,
    required this.totalPark,
    required this.totalStreet,
    this.startWorkAt,
    this.stopWorkAt,
    this.startSchedule,
    this.stopSchedule,
    required this.statusCode,
  });

  static TaskList fromJson(json) => TaskList(
        id: json['id'] ?? 0,
        vehicleNo: json['vehicle_no'],
        mainRoute: json['main_route'],
        scheduleDate: json['schedule_date'],
        totalSubRoute: json['total_sub_route'],
        totalPark: json['total_park'],
        totalStreet: json['total_street'],
        startWorkAt: json['start_work_at'],
        stopWorkAt: json['stop_work_at'],
        startSchedule: json['start_schedule_at'],
        stopSchedule: json['stop_schedule_at'],
        statusCode: Status.fromJson(json['status_code']),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vehicle_no'] = vehicleNo;
    data['main_route'] = mainRoute;
    data['schedule_date'] = scheduleDate;
    data['total_sub_route'] = totalSubRoute;
    data['total_park'] = totalPark;
    data['total_street'] = totalStreet;
    data['start_schedule_at'] = startWorkAt;
    data['stop_schedule_at'] = stopWorkAt;
    data['status_code'] = statusCode.toJson();
    return data;
  }
}

class Status {
  final String code;
  final String name;

  const Status({required this.code, required this.name});

  static Status fromJson(json) => Status(
        code: json['code'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
