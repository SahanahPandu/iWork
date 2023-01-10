import '../report_details/report_details_info.dart';

class ReportData {
  final List<ReportDetailsInfo>? data;
  final String status;
  final String? message;

  const ReportData({
    required this.data,
    required this.status,
    this.message,
  });

  factory ReportData.fromJson(json) => ReportData(
        data: json['data']['reports']
            .map<ReportDetailsInfo>(ReportDetailsInfo.fromJson)
            .toList(),
        // data: json["data"],
        status: json["status"],
        message: json["message"],
      );

  // Map<String, dynamic> toJson() => {
  //       "data": data.toJson(),
  //       "status": status,
  //       "message": message,
  //     };
}
