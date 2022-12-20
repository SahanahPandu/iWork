import './ecuti_details.dart';

class EcutiData {
  final List<EcutiDetails?>? data;
  final String status;
  final String? message;

  const EcutiData({
    required this.data,
    required this.status,
    this.message,
  });

  factory EcutiData.fromJson(json) => EcutiData(
        data: json['data']['leave']
                .map<EcutiDetails>(EcutiDetails.fromJson)
                .toList() ??
            [],
        status: json['status'],
        message: json['message'],
      );
}
