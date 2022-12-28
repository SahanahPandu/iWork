class UserAttendanceId {
  UserAttendanceId({
    this.id,
    this.clockInAt,
    this.clockOutAt,
  });

  int? id;
  String? clockInAt;
  String? clockOutAt;

  factory UserAttendanceId.fromJson(Map<String, dynamic> json) =>
      UserAttendanceId(
        id: json["id"],
        clockInAt: json["clock_in_at"],
        clockOutAt: json["clock_out_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clock_in_at": clockInAt,
        "clock_out_at": clockOutAt,
      };
}
