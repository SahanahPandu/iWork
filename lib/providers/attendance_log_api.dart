import 'dart:convert';
import 'package:flutter/material.dart';

//import files
import '../models/attendance_log/attendance_log.dart';

class AttendanceLogApi {
  static Future<List<AttendanceLog>> getAttendanceLogData(
      BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_attendance_log.json');
    final data = json.decode(jsonData);

    return data.map<AttendanceLog>(AttendanceLog.fromJson).toList();
  }
}
