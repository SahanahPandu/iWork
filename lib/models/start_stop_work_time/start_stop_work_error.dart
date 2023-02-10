class StartStopWorkError {
  StartStopWorkError({
    this.data,
    required this.status,
    required this.message,
    required this.error,
  });

  dynamic data;
  String status;
  String message;
  String error;

  factory StartStopWorkError.fromJson(Map<String, dynamic> json) =>
      StartStopWorkError(
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
