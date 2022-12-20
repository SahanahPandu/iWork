class ReportDetailsInfo {
  final int id;
  final ScheduleCollectionMain? schCollectionMain;
  final String subRouteName;
  final Park? park;
  final Street? street;
  final Status? status;
  final ObstacleType? obstacleType;
  final UploadFile? uploadFileId;
  final String? remarks;
  final String? svRemarks;

  const ReportDetailsInfo({
    required this.id,
    this.schCollectionMain,
    required this.subRouteName,
    this.park,
    this.street,
    this.status,
    this.obstacleType,
    this.uploadFileId,
    this.remarks,
    this.svRemarks,
  });

  factory ReportDetailsInfo.fromJson(json) => ReportDetailsInfo(
        id: json['id'] ?? 0,
        schCollectionMain: json['sc_main_id'] != null
            ? ScheduleCollectionMain.fromJson(json['sc_main_id'])
            : null,
        subRouteName: json['sub_route_name'] ?? "",
        park: json['park_id'] != null ? Park.fromJson(json['park_id']) : null,
        street: json['street_id'] != null
            ? Street.fromJson(json['street_id'])
            : null,
        status: json['status_code'] != null
            ? Status.fromJson(json['status_code'])
            : null,
        obstacleType: json['obstacle_type_id'] != null
            ? ObstacleType.fromJson(json['obstacle_type_id'])
            : null,
        uploadFileId: json['upload_file_id'] != null
            ? UploadFile.fromJson(json['upload_file_id'])
            : null,
        remarks: json['remarks'] ?? "",
        svRemarks: json['sv_remarks'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['sc_main_id'] = schCollectionMain;
    data['sub_route_name'] = subRouteName;
    data['park_id'] = park;
    data['street_id'] = street;
    data['status_code'] = status;
    data['obstacle_type_id'] = obstacleType;
    data['upload_file_id'] = uploadFileId;
    data['remarks'] = remarks;
    data['sv_remarks'] = svRemarks;

    return data;
  }
}

class ScheduleCollectionMain {
  final int id;
  final String mainRoute;

  const ScheduleCollectionMain({
    required this.id,
    required this.mainRoute,
  });

  factory ScheduleCollectionMain.fromJson(json) => ScheduleCollectionMain(
        id: json['id'],
        mainRoute: json['main_route'],
      );
}

class Park {
  final int parkId;
  final String parkName;

  const Park({
    required this.parkId,
    required this.parkName,
  });

  factory Park.fromJson(json) => Park(
        parkId: json['park_pdibId'],
        parkName: json['parkName'],
      );
}

class Street {
  final int streetId;
  final String streetName;

  const Street({
    required this.streetId,
    required this.streetName,
  });

  factory Street.fromJson(json) => Street(
        streetId: json['street_pdibId'],
        streetName: json['streetName'],
      );
}

class Status {
  final String statusCode;
  final String statusName;

  const Status({
    required this.statusCode,
    required this.statusName,
  });

  factory Status.fromJson(json) => Status(
        statusCode: json['code'],
        statusName: json['name'],
      );
}

class ObstacleType {
  final int obsTypeId;
  final String obsTypeName;

  const ObstacleType({
    required this.obsTypeId,
    required this.obsTypeName,
  });

  factory ObstacleType.fromJson(json) => ObstacleType(
        obsTypeId: json['id'],
        obsTypeName: json['name'],
      );
}

class UploadFile {
  final int id;
  final String fileName;
  final String filePath;

  const UploadFile({
    required this.id,
    required this.fileName,
    required this.filePath,
  });

  factory UploadFile.fromJson(json) => UploadFile(
        id: json['id'],
        fileName: json['file_name'],
        filePath: json['file_path'],
      );
}
