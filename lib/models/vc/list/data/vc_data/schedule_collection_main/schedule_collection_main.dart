import 'package:eswm/models/vc/list/data/vc_data/schedule_collection_main/supervise_by/supervise_by.dart';

class ScheduleCollectionMain {
  ScheduleCollectionMain({
    this.id,
    this.mainRoute,
    this.vehicleChecklistId,
    this.superviseBy,
  });

  int? id;
  String? mainRoute;
  int? vehicleChecklistId;
  SuperviseBy? superviseBy;

  factory ScheduleCollectionMain.fromJson(Map<String, dynamic> json) =>
      ScheduleCollectionMain(
        id: json["id"],
        mainRoute: json["main_route"],
        vehicleChecklistId: json["vehicle_checklist_id"],
        superviseBy: json["supervise_by"] == null
            ? null
            : SuperviseBy.fromJson(json["supervise_by"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main_route": mainRoute,
        "vehicle_checklist_id": vehicleChecklistId,
        "supervise_by": superviseBy!.toJson(),
      };
}
