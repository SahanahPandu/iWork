import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class EcutiDetails {
  final int id;

  //check the key is exist or the data is null
  //default value will be null
  @JsonKey(defaultValue: null)
  final dynamic userId;

  final String dateFrom;
  final String dateTo;
  final String? remarks;
  final String statusCode;
  final int? uploadFileId;
  final int leaveTypeId;
  final String? remarksBySv;
  final LeaveType? leaveType;
  final Status? status;
  final UploadFile? uploadFile;

  const EcutiDetails({
    required this.id,
    this.userId,
    required this.dateFrom,
    required this.dateTo,
    this.remarks,
    required this.statusCode,
    this.uploadFileId,
    required this.leaveTypeId,
    this.remarksBySv,
    this.leaveType,
    this.status,
    this.uploadFile,
  });

  factory EcutiDetails.fromJson(json) => EcutiDetails(
        id: json['id'],
        userId: json['user_id'],
        dateFrom: json['date_leave_from'],
        dateTo: json['date_leave_to'],
        remarks: json['remarks'] ?? "",
        statusCode: json['status_code'],
        uploadFileId: json['upload_file_id'] ?? 0,
        leaveTypeId: json['leave_type_id'],
        remarksBySv: json['remarks_by_sv'] ?? "",
        leaveType: json['leave_type'] != null
            ? LeaveType.fromJson(json['leave_type'])
            : null,
        status: json['status'] != null ? Status.fromJson(json['status']) : null,
        uploadFile: json['upload_file'] != null
            ? UploadFile.fromJson(json['upload_file'])
            : null,
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
