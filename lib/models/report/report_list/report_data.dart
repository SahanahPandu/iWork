import 'report_details.dart';

class ReportData {
  final List<ReportDetails> data;
  final String status;
  final String? message;

  const ReportData({
    required this.data,
    required this.status,
    this.message,
  });

  factory ReportData.fromJson(json) => ReportData(
        data: json['data']['reports']
            .map<ReportDetails>(ReportDetails.fromJson)
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
