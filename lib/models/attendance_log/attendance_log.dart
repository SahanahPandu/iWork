import 'days/day1.dart';
import 'days/day2.dart';
import 'days/day3.dart';
import 'days/day4.dart';
import 'days/day5.dart';

class AttendanceLog {
  final Day1 day1;
  final Day2 day2;
  final Day3 day3;
  final Day4 day4;
  final Day5 day5;

  const AttendanceLog(
      {required this.day1,
      required this.day2,
      required this.day3,
      required this.day4,
      required this.day5});

  static AttendanceLog fromJson(json) => AttendanceLog(
        day1: Day1.fromJson(json["day1"]),
        day2: Day2.fromJson(json["day2"]),
        day3: Day3.fromJson(json["day3"]),
        day4: Day4.fromJson(json["day4"]),
        day5: Day5.fromJson(json["day5"]),
      );
}
