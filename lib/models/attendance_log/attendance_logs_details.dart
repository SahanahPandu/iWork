class AttendanceLogsDetails {
  final int id;
  final String attendanceDate;
  final String? clockIn;
  final String? clockOut;
  final int? isVerified;

  const AttendanceLogsDetails({
    required this.id,
    required this.attendanceDate,
    this.clockIn,
    this.clockOut,
    this.isVerified,
  });

  factory AttendanceLogsDetails.fromJson(json) => AttendanceLogsDetails(
        id: json['id'],
        attendanceDate: json['attendance_date'],
        clockIn: json['clock_in_at'],
        clockOut: json['clock_out_at'],
        isVerified: json['is_verified'],
      );
}
