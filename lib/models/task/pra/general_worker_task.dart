import 'package:eswm/models/task/pra/task_list.dart';
import 'package:json_annotation/json_annotation.dart';

class GeneralWorkerTask {
  @JsonKey(defaultValue: null)
  final String? startSchedule;

  @JsonKey(defaultValue: null)
  final String? stopSchedule;

  @JsonKey(defaultValue: {})
  final Attendance? attendance;

  @JsonKey(defaultValue: [])
  final List<TaskList> list;

  const GeneralWorkerTask({
    required this.startSchedule,
    required this.stopSchedule,
    this.attendance,
    required this.list,
  });

  static GeneralWorkerTask fromJson(Map<String, dynamic> json) =>
      GeneralWorkerTask(
        startSchedule: json['start_schedule'],
        stopSchedule: json['stop_schedule'],
        attendance: json['attendance'] != null
            ? Attendance.fromJson(json['attendance'])
            : null,
        list: json['list'] != []
            ? json['list'].map<TaskList>(TaskList.fromJson).toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        "list": list,
      };
}

class Attendance {
  final String? clockIn;
  final String? clockOut;

  const Attendance({
    this.clockIn,
    this.clockOut,
  });

  factory Attendance.fromJson(json) => Attendance(
        clockIn: (json['clock_in_at'] != null) ? json['clock_in_at'] : "",
        clockOut: (json['clock_out_at'] != null) ? json['clock_out_at'] : "",
      );
}
