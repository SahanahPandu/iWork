import 'package:eswm/models/task/compactor/data/schedules/schedule.dart';

class Data {
  Data({
    required this.schedules,
  });

  List<Schedule> schedules;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        schedules: List<Schedule>.from(
            json["schedules"].map((x) => Schedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "schedules": List<dynamic>.from(schedules.map((x) => x.toJson())),
      };
}
