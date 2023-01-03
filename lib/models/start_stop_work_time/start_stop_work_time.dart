class StartStopWorkTime {
  StartStopWorkTime({
    this.data,
    required this.status,
    required this.message,
    this.error,
  });

  dynamic data;
  String status;
  String message;
  dynamic error;

  factory StartStopWorkTime.fromJson(Map<String, dynamic> json) =>
      StartStopWorkTime(
        data: json["data"] ?? "",
        status: json["status"],
        message: json["message"],
        error: json["error"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "status": status,
        "message": message,
        "error": error,
      };
}
