import 'package:json_annotation/json_annotation.dart';

import '../user/user_data.dart';

@JsonSerializable()
class EcutiDetails {
  final int id;

  @JsonKey(defaultValue: null)
  final UserData? userId;

  @JsonKey(defaultValue: "")
  final String? dateFrom;

  @JsonKey(defaultValue: "")
  final String? dateTo;

  @JsonKey(defaultValue: "")
  final String? remarks;

  @JsonKey(defaultValue: null)
  final Status? status;

  @JsonKey(defaultValue: null)
  final UploadFile? uploadFile;

  @JsonKey(defaultValue: null)
  final LeaveType? leaveType;

  @JsonKey(defaultValue: "")
  final String? remarksBySv;

  const EcutiDetails({
    required this.id,
    this.userId,
    required this.dateFrom,
    required this.dateTo,
    this.remarks,
    this.status,
    this.uploadFile,
    this.leaveType,
    this.remarksBySv,
  });

  factory EcutiDetails.fromJson(json) => EcutiDetails(
        id: json['id'],
        userId:
            json['user_id'] != null ? UserData.fromJson(json['user_id']) : null,
        dateFrom: json['date_leave_from'],
        dateTo: json['date_leave_to'],
        remarks: json['remarks'] ?? "",
        status: json['status_code'] != null
            ? Status.fromJson(json['status_code'])
            : null,
        uploadFile: json['upload_file_id'] != null
            ? UploadFile.fromJson(json['upload_file_id'])
            : null,
        leaveType: json['leave_type_id'] != null
            ? LeaveType.fromJson(json['leave_type_id'])
            : null,
        remarksBySv: json['remarks_by_sv'],
      );
}

class LeaveType {
  final int id;
  final String name;

  const LeaveType({
    required this.id,
    required this.name,
  });

  factory LeaveType.fromJson(json) => LeaveType(
        id: json['id'],
        name: json['name'],
      );
}

class Status {
  final String code;
  final String name;

  const Status({
    required this.code,
    required this.name,
  });

  factory Status.fromJson(json) => Status(
        code: json['code'],
        name: json['name'],
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
