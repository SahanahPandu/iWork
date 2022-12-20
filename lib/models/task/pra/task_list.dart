class TaskList {
  final int scMainId;
  final String vehicleNo;
  final String mainRoute;
  final String scheduleDate;
  final int totalSubRoute;
  final int totalPark;
  final int totalStreet;
  final String startWorkAt;
  final String stopWorkAt;
  final Status statusCode;

  const TaskList({
    required this.scMainId,
    required this.vehicleNo,
    required this.mainRoute,
    required this.scheduleDate,
    required this.totalSubRoute,
    required this.totalPark,
    required this.totalStreet,
    required this.startWorkAt,
    required this.stopWorkAt,
    required this.statusCode,
  });

  static TaskList fromJson(json) => TaskList(
        scMainId: json['sc_main_id'] ?? 0,
        vehicleNo: json['vehicle_no'],
        mainRoute: json['main_route'],
        scheduleDate: json['schedule_date'],
        totalSubRoute: json['total_sub_route'],
        totalPark: json['total_park'],
        totalStreet: json['total_street'],
        startWorkAt: json['start_work_at'],
        stopWorkAt: json['stop_work_at'],
        statusCode: Status.fromJson(json['status_code']),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sc_main_id'] = scMainId;
    data['vehicle_no'] = vehicleNo;
    data['main_route'] = mainRoute;
    data['schedule_date'] = scheduleDate;
    data['total_sub_route'] = totalSubRoute;
    data['total_park'] = totalPark;
    data['total_street'] = totalStreet;
    data['start_work_at'] = startWorkAt;
    data['stop_work_at'] = stopWorkAt;
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
