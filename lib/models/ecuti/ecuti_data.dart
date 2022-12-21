import 'package:eswm/models/ecuti/ecuti_paging.dart';

class EcutiData {
  final EcutiPaging? data;
  final String status;
  final String? message;

  const EcutiData({
    required this.data,
    required this.status,
    this.message,
  });

  factory EcutiData.fromJson(json) => EcutiData(
        data: EcutiPaging.fromJson(json['data']),
        status: json['status'],
        message: json['message'],
      );
}
