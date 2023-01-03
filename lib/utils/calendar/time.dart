import 'package:intl/intl.dart';

class Time {
  static String getCurrentTime() {
    var now = DateTime.now();
    var formatter = DateFormat("hh:mm a");
    return formatter.format(now);
  }

  static String getCurrentTimeInHHMM() {
    var now = DateTime.now();
    var formatter = DateFormat("hh:mm");
    return formatter.format(now);
  }

  static String convertToHM(String time) {
    var convertDate =
        "${DateFormat("hh:mm").format(DateTime.parse("2023-01-03 $time"))} ${convertAMPMToMs(time)}";
    return convertDate;
  }

  static String convertAMPMToMs(String time) {
    int hour =
        int.parse(DateFormat("HH").format(DateTime.parse("2023-01-03 $time")));
    if (hour >= 0 && hour <= 12) {
      return "Pagi";
    } else if (hour >= 12 && hour <= 14) {
      return "Tengah hari";
    } else if (hour >= 14 && hour <= 19) {
      return "Petang";
    } else if (hour >= 19 && hour <= 24) {
      return "Malam";
    }
    return DateFormat("a", "ms").format(DateTime.parse(time));
  }
}
