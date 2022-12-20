class ActivityCode {
  ActivityCode({
    required this.activityCode,
    required this.activityName,
  });

  String activityCode;
  String activityName;

  factory ActivityCode.fromJson(Map<String, dynamic> json) => ActivityCode(
        activityCode: json["activity_code"],
        activityName: json["activity_name"],
      );

  Map<String, dynamic> toJson() => {
        "activity_code": activityCode,
        "activity_name": activityName,
      };
}
