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
}
