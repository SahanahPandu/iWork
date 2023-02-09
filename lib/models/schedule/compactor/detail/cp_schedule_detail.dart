import '../../schedule_data_detail_cp_sv/schedule_detail.dart';

class CScheduleDetail {
  CScheduleDetail({
    this.data,
    this.status,
    this.message,
  });

  Data? data;
  String? status;
  dynamic message;

  factory CScheduleDetail.fromJson(Map<String, dynamic> json) =>
      CScheduleDetail(
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

class Data {
  Data({
    this.details,
  });

  Details? details;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        details: Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "details": details!.toJson(),
      };
}

