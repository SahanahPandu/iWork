import 'package:json_annotation/json_annotation.dart';

import '../../../../../vc/detail/data/vehicle_checklists/checklist_after/checklist_after.dart';
import '../../../../../vc/detail/data/vehicle_checklists/checklist_before/checklist_before.dart';
import '../status_code/status_code.dart';

class VehicleChecklistId {
  VehicleChecklistId({
    this.id,
    this.vehicleNo,
    this.statusCode,
    this.timeIn,
    this.timeOut,
    this.checklistBefore,
    this.checklistAfter,
    this.remarks,
    this.noLaluan,
    this.odometerBefore,
    this.odometerAfter,
    this.verifiedBy,
    this.verifiedAt,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? vehicleNo;
  StatusCode? statusCode;
  String? timeIn;
  String? timeOut;

  @JsonKey(defaultValue: null)
  ChecklistBefore? checklistBefore;

  @JsonKey(defaultValue: null)
  ChecklistAfter? checklistAfter;

  @JsonKey(defaultValue: "")
  String? remarks;

  @JsonKey(defaultValue: "")
  String? noLaluan;

  @JsonKey(defaultValue: "")
  dynamic odometerBefore;

  @JsonKey(defaultValue: "")
  dynamic odometerAfter;

  @JsonKey(defaultValue: "")
  dynamic verifiedBy;

  @JsonKey(defaultValue: "")
  dynamic verifiedAt;

  @JsonKey(defaultValue: "")
  int? createdBy;

  @JsonKey(defaultValue: 0)
  int? updatedBy;

  @JsonKey(defaultValue: "")
  String? createdAt;

  @JsonKey(defaultValue: "")
  String? updatedAt;

  factory VehicleChecklistId.fromJson(Map<String, dynamic> json) =>
      VehicleChecklistId(
        id: json["id"],
        vehicleNo: json["vehicle_no"],
        statusCode: StatusCode.fromJson(json["status_code"]),
        timeIn: json["time_in"] ?? "--:--",
        timeOut: json["time_out"] ?? "--:--",
        checklistBefore: json["checklist_before"] != null
            ? ChecklistBefore.fromJson(json["checklist_before"])
            : null,
        checklistAfter: json["checklist_after"] != null
            ? ChecklistAfter.fromJson(json["checklist_after"])
            : null,
        remarks: json["remarks"] ?? "",
        noLaluan: json["no_laluan"] ?? "",
        odometerBefore: json["odometer_before"] ?? "",
        odometerAfter: json["odometer_after"] ?? "",
        verifiedBy: json["verified_by"] ?? "",
        verifiedAt: json["verified_at"] ?? "",
        createdBy: json["created_by"] ?? 0,
        updatedBy: json["updated_by"] ?? 0,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle_no": vehicleNo,
        "status_code": statusCode!.toJson(),
        "time_in": timeIn,
        "time_out": timeOut,
        "checklist_before": checklistBefore!.toJson(),
        "checklist_after": checklistAfter!.toJson(),
        "remarks": remarks,
        "no_laluan": noLaluan,
        "odometer_before": odometerBefore,
        "odometer_after": odometerAfter,
        "verified_by": verifiedBy,
        "verified_at": verifiedAt,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
