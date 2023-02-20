class VCVerificationList {
  VCVerificationList({
    required this.data,
    required this.status,
    required this.message,
  });

  Data data;
  String status;
  String message;

  factory VCVerificationList.fromJson(Map<String, dynamic> json) =>
      VCVerificationList(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class Data {
  Data({
    this.checklist,
  });

  List<ChecklistList>? checklist;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        checklist: json["checklist"] != null
            ? List<ChecklistList>.from(
                json["checklist"].map((x) => ChecklistList.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "checklist": List<dynamic>.from(checklist!.map((x) => x.toJson())),
      };
}

class ChecklistList {
  ChecklistList({
    required this.id,
    required this.mainRoute,
    required this.vehicleNo,
    required this.vehicleChecklistId,
  });

  int id;
  String mainRoute;
  String vehicleNo;
  VehicleChecklistId vehicleChecklistId;

  factory ChecklistList.fromJson(Map<String, dynamic> json) => ChecklistList(
        id: json["id"],
        mainRoute: json["main_route"],
        vehicleNo: json["vehicle_no"],
        vehicleChecklistId:
            VehicleChecklistId.fromJson(json["vehicle_checklist_id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main_route": mainRoute,
        "vehicle_no": vehicleNo,
        "vehicle_checklist_id": vehicleChecklistId.toJson(),
      };
}

class VehicleChecklistId {
  VehicleChecklistId({
    required this.id,
    required this.statusCode,
  });

  int id;
  StatusCode statusCode;

  factory VehicleChecklistId.fromJson(Map<String, dynamic> json) =>
      VehicleChecklistId(
        id: json["id"],
        statusCode: StatusCode.fromJson(json["status_code"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status_code": statusCode.toJson(),
      };
}

class StatusCode {
  StatusCode({
    required this.code,
    required this.name,
  });

  String code;
  String name;

  factory StatusCode.fromJson(Map<String, dynamic> json) => StatusCode(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}
