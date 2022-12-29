import 'package:json_annotation/json_annotation.dart';

import 'checklist_after/checklist_after.dart';
import 'checklist_before/checklist_before.dart';

class VehicleChecklists {
  VehicleChecklists({
    required this.id,
    this.timeIn,
    this.timeOut,
    this.createdAt,
    required this.statusCode,
    this.checklistBefore,
    this.checklistAfter,
  });

  int id;
  @JsonKey(defaultValue: "")
  dynamic timeIn;
  @JsonKey(defaultValue: "")
  dynamic timeOut;
  dynamic createdAt;
  String statusCode;
  ChecklistBefore? checklistBefore;

  @JsonKey(defaultValue: null)
  ChecklistAfter? checklistAfter;

  factory VehicleChecklists.fromJson(Map<String, dynamic> json) =>
      VehicleChecklists(
        id: json["id"],
        timeIn: json["time_in"] ?? "--:--",
        timeOut: json["time_out"] ?? "--:--",
        createdAt: json["created_at"] ?? "--:--",
        statusCode: json["status_code"],
        checklistBefore: json["checklist_before"] != null
            ? ChecklistBefore.fromJson(json["checklist_before"])
            : null,
        checklistAfter: json["checklist_after"] != null
            ? ChecklistAfter.fromJson(json["checklist_after"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time_in": timeIn,
        "time_out": timeOut,
        "created_at": createdAt,
        "status_code": statusCode,
        "checklist_before": checklistBefore,
        "checklist_after": checklistAfter,
      };
}
