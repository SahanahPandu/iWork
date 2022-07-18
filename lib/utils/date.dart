import 'package:intl/intl.dart';

class Date {

  static String getTodayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(now);
  }

  static String getCurrentTime()  {
    var now = DateTime.now();
    var formatter = DateFormat("hh:mm a");
    return formatter.format(now);
  }

}
