class ReportOfSchedule {
  ReportOfSchedule({
    required this.data,
    this.status,
    this.message,
  });

  Data data;
  String? status;
  String? message;

  factory ReportOfSchedule.fromJson(Map<String, dynamic> json) =>
      ReportOfSchedule(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class Data {
  Data({
    required this.reports,
  });

  List<Report> reports;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        reports:
            List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reports": List<dynamic>.from(reports.map((x) => x.toJson())),
      };
}

class Report {
  Report({
    this.id,
    this.schCollectionMain,
    this.park,
    this.street,
    this.status,
    this.obstacleType,
    this.createdAt,
  });

  int? id;
  ScMainId? schCollectionMain;
  ParkId? park;
  StreetId? street;
  StatusCode? status;
  ObstacleTypeId? obstacleType;
  String? createdAt;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        schCollectionMain: json["sc_main_id"] != null
            ? ScMainId.fromJson(json["sc_main_id"])
            : null,
        park: json["park_id"] != null ? ParkId.fromJson(json["park_id"]) : null,
        street: json["street_id"] != null
            ? StreetId.fromJson(json["street_id"])
            : null,
        status: json["status_code"] != null
            ? StatusCode.fromJson(json["status_code"])
            : null,
        obstacleType: json["obstacle_type_id"] != null
            ? ObstacleTypeId.fromJson(json["obstacle_type_id"])
            : null,
        createdAt: json["created_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sc_main_id": schCollectionMain!.toJson(),
        "park_id": park!.toJson(),
        "street_id": street!.toJson(),
        "status_code": status!.toJson(),
        "obstacle_type_id": obstacleType!.toJson(),
        "created_at": createdAt,
      };
}

class ObstacleTypeId {
  ObstacleTypeId({
    required this.id,
    required this.obsTypeName,
  });

  int id;
  String obsTypeName;

  factory ObstacleTypeId.fromJson(Map<String, dynamic> json) => ObstacleTypeId(
        id: json["id"],
        obsTypeName: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": obsTypeName,
      };
}

class ParkId {
  ParkId({
    required this.parkPdibId,
    required this.parkName,
  });

  int parkPdibId;
  String parkName;

  factory ParkId.fromJson(Map<String, dynamic> json) => ParkId(
        parkPdibId: json["park_pdibId"],
        parkName: json["parkName"],
      );

  Map<String, dynamic> toJson() => {
        "park_pdibId": parkPdibId,
        "parkName": parkName,
      };
}

class ScMainId {
  ScMainId({
    required this.id,
    required this.mainRoute,
    required this.vehicleNo,
  });

  int id;
  String mainRoute;
  String vehicleNo;

  factory ScMainId.fromJson(Map<String, dynamic> json) => ScMainId(
        id: json["id"],
        mainRoute: json["main_route"],
        vehicleNo: json["vehicle_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main_route": mainRoute,
        "vehicle_no": vehicleNo,
      };
}

class StatusCode {
  StatusCode({
    required this.statusCode,
    required this.statusName,
  });

  String statusCode;
  String statusName;

  factory StatusCode.fromJson(Map<String, dynamic> json) => StatusCode(
        statusCode: json["code"],
        statusName: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "name": statusName,
      };
}

class StreetId {
  StreetId({
    required this.streetPdibId,
    required this.streetName,
  });

  int streetPdibId;
  String streetName;

  factory StreetId.fromJson(Map<String, dynamic> json) => StreetId(
        streetPdibId: json["street_pdibId"],
        streetName: json["streetName"],
      );

  Map<String, dynamic> toJson() => {
        "street_pdibId": streetPdibId,
        "streetName": streetName,
      };
}
