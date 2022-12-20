import 'package:eswm/models/task/pra/task_list.dart';

class GeneralWorkerTask {
  final String? startWork;
  final String? stopWork;
  final Attendance? attendance;
  final List<TaskList> list;

  const GeneralWorkerTask({
    required this.startWork,
    required this.stopWork,
    this.attendance,
    required this.list,
  });

  static GeneralWorkerTask fromJson(Map<String, dynamic> json) =>
      GeneralWorkerTask(
        startWork: json['startWork'] ?? "",
        stopWork: json['stopWork'] ?? "",
        attendance: json['attendance'] != null
            ? Attendance.fromJson(json['attendance'])
            : null,
        list: json['list'].map<TaskList>(TaskList.fromJson).toList(),
      );

  Map<String, dynamic> toJson() => {
        "list": list,
      };
}

class Attendance {
  final String? clockIn;
  final String? clockOut;

  const Attendance({
    required this.clockIn,
    required this.clockOut,
  });

  factory Attendance.fromJson(json) => Attendance(
        clockIn: (json['clock_in_at'] != null) ? json['clock_in_at'] : null,
        clockOut: (json['clock_out_at'] != null) ? json['clock_out_at'] : null,
      );
}
