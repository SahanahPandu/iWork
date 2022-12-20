import 'package:eswm/models/options/option_details.dart';

class OptionsData {
  final OptionDetails? data;
  final dynamic status;
  final dynamic message;

  OptionsData({
    this.data,
    required this.status,
    required this.message,
  });

  factory OptionsData.fromJson(json) => OptionsData(
        data: OptionDetails.fromJson(json['data']),
        status: json['status'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "status": status,
        "message": message,
      };
}
