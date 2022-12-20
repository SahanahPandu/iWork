import 'dart:convert';

class LoginError {
  LoginError({
    this.data,
    required this.status,
    required this.message,
    required this.error,
  });

  dynamic data;
  String status;
  String message;
  String error;

  factory LoginError.fromJson(Map<String, dynamic> json) => LoginError(
        data: json["data"],
        status: json["status"],
        message: json["message"],
        error: json["error"],
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
