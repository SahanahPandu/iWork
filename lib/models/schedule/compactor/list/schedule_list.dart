import 'data/data.dart';

class ScheduleList {
  ScheduleList({
    this.data,
    this.status,
    this.message,
  });

  Data? data;
  String? status;
  String? message;

  factory ScheduleList.fromJson(Map<String, dynamic> json) => ScheduleList(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "status": status,
        "message": message,
      };
}
