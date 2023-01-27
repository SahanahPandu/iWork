import 'package:eswm/models/vc/list/data/vc_data/schedule_collection_main/schedule_collection_main.dart';

import '../../../../task/compactor/data/schedule/status_code/status_code.dart';

class VCListDetail {
  VCListDetail({
    this.id,
    this.vehicleNo,
    this.statusCode,
    this.createdAt,
    this.scheduleCollectionMain,
  });

  int? id;
  String? vehicleNo;
  StatusCode? statusCode;
  String? createdAt;
  ScheduleCollectionMain? scheduleCollectionMain;

  factory VCListDetail.fromJson(Map<String, dynamic> json) => VCListDetail(
        id: json["id"] ?? 0,
        vehicleNo: json["vehicle_no"] ?? "",
        statusCode: json["status_code"] != null
            ? StatusCode.fromJson(json["status_code"])
            : null,
        createdAt: json["created_at"] ?? "",
        scheduleCollectionMain: json["schedule_collection_main"] != null
            ? ScheduleCollectionMain.fromJson(json["schedule_collection_main"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle_no": vehicleNo,
        "status_code": statusCode!.toJson(),
        "created_at": createdAt,
        "schedule_collection_main": scheduleCollectionMain!.toJson(),
      };
}
