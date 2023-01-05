import 'dart:convert';

import 'error/error.dart';

class LoginError {
  LoginError({
    this.data,
    required this.status,
    required this.message,
    this.errorStr,
  });

  dynamic data;
  String status;
  String message;
  String? errorStr;

  factory LoginError.fromJson(Map<String, dynamic> json) => LoginError(
        data: json["data"],
        status: json["status"],
        message: json["message"],
        errorStr: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "status": status,
        "message": message,
        "error": errorStr,
      };
}

LoginError errorFromJson(String str) => LoginError.fromJson(json.decode(str));

String errorToJson(LoginError data) => json.encode(data.toJson());
