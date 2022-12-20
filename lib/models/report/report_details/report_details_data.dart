import 'report_details_info.dart';

class ReportDetailsData {
  final ReportDetailsInfo data;
  final String status;
  final String? message;

  const ReportDetailsData({
    required this.data,
    required this.status,
    this.message,
  });

  factory ReportDetailsData.fromJson(json) => ReportDetailsData(
        data: ReportDetailsInfo.fromJson(json['data']['reports']),
        status: json["status"],
        message: json["message"],
      );

  // Map<String, dynamic> toJson() => {
  //       "data": data.toJson(),
  //       "status": status,
  //       "message": message,
  //     };
}
