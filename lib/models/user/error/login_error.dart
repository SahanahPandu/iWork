import 'dart:convert';

import 'error/error.dart';

class LoginError {
  LoginError({
    this.data,
    required this.status,
    required this.message,
    this.error,
    this.errorStr,
  });

  dynamic data;
  String status;
  String message;
  ErrorPart? error;
  String? errorStr;

  factory LoginError.fromJson(Map<String, dynamic> json) => LoginError(
        data: json["data"],
        status: json["status"],
        message: json["message"],
        error: json["error"],
        errorStr: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "status": status,
        "message": message,
        "error": error,
      };
}

LoginError errorFromJson(String str) => LoginError.fromJson(json.decode(str));

String errorToJson(LoginError data) => json.encode(data.toJson());
