import 'package:intl/intl.dart';

//import files
import '../../config/config.dart';
import 'date.dart';

class Time {
  static String getCurrentTime() {
    var now = DateTime.now();
    var formatter = DateFormat("hh:mm a");
    return formatter.format(now);
  }

  static String getCurrentTimeInHHMMSS() {
    var now = DateTime.now();
    var formatter = DateFormat("hh:mm:ss");
    return formatter.format(now);
  }

  static String convertToHM(String time) {
    var convertDate = DateFormat("hh:mm a")
        .format(DateTime.parse("2023-01-03 $time"))
        .toLowerCase();
    return convertDate;
  }

  static String convertAMPMToMs(String time) {
    if (time != "") {
      int hour = int.parse(
          DateFormat("HH").format(DateTime.parse("2023-01-03 $time")));
      if (hour >= 0 && hour <= 11) {
        return "Pagi";
      } else if (hour >= 12 && hour <= 14) {
        return "Tengah hari";
      } else if (hour >= 15 && hour <= 18) {
        return "Petang";
      } else if (hour >= 19 && hour <= 24) {
        return "Malam";
      }
    }
    return DateFormat("a", "ms").format(DateTime.parse(time));
  }

  static String getTodayTaskTimeForCollapseHeader(
      String startTime, String stopTime) {
    String convStartTime = "";
    String convStopTime = "";
    if (startTime != "--:--" && stopTime != "--:--") {
      convStartTime = DateFormat("hh:mm a")
          .format(DateTime.parse('20222312 $startTime'))
          .toLowerCase();
      convStopTime = DateFormat("hh:mm a")
          .format(DateTime.parse('20222312 $stopTime'))
          .toLowerCase();
    }

    if (otherDate && selectedNewDate != '') {
      if (Date.isDateExpired(DateTime.parse(selectedNewDate))) {
        if (convStartTime != "" && convStopTime != "") {
          return "Tugasan Masa Lalu ($convStartTime - $convStopTime)";
        } else if (convStartTime == "" && convStopTime != "") {
          return "Tugasan Masa Lalu (--:$convStopTime)";
        } else if (convStartTime != "" && convStopTime == "") {
          return "Tugasan Masa Lalu ($convStartTime:--)";
        }
        return "Tugasan Masa Lalu ( --:-- )";
      } else {
        if (convStartTime != "" && convStopTime != "") {
          return "Tugasan Akan Datang ($convStartTime - $convStopTime)";
        } else if (convStartTime == "" && convStopTime != "") {
          return "Tugasan Akan Datang (--:$convStopTime)";
        } else if (convStartTime != "" && convStopTime == "") {
          return "Tugasan Akan Datang ($convStartTime:--)";
        }
        return "Tugasan Akan Datang ( --:-- )";
      }
    } else {
      if (convStartTime != "" && convStopTime != "") {
        return "Tugasan Hari Ini ($convStartTime - $convStopTime)";
      } else if (convStartTime == "" && convStopTime != "") {
        return "Tugasan Hari Ini (--:$convStopTime)";
      } else if (convStartTime != "" && convStopTime == "") {
        return "Tugasan Hari Ini ($convStartTime:--)";
      }
      return "Tugasan Hari Ini ( --:-- )";
    }
  }
}
