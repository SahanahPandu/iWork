import 'package:eswm/models/vc/list/data/vc_data/schedule_collection_main/schedule_collection_main.dart';

import '../../../../task/compactor/data/schedule/vehicle_checklist_id/status_code/status_code.dart';

class VCData {
  VCData({
    this.id,
    this.vehicleNo,
    this.statusCode,
    this.createdAt,
    this.scheduleCollectionMain,
  });

  int? id;
  String? vehicleNo;
  StatusCode? statusCode;
  DateTime? createdAt;
  ScheduleCollectionMain? scheduleCollectionMain;

  factory VCData.fromJson(Map<String, dynamic> json) => VCData(
        id: json["id"],
        vehicleNo: json["vehicle_no"],
        statusCode: StatusCode.fromJson(json["status_code"]),
        createdAt: DateTime.parse(json["created_at"]),
        scheduleCollectionMain:
            ScheduleCollectionMain.fromJson(json["schedule_collection_main"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle_no": vehicleNo,
        "status_code": statusCode!.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "schedule_collection_main": scheduleCollectionMain!.toJson(),
      };
}
