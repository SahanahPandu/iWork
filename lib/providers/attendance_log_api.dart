// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eswm/config/config.dart';
import 'package:eswm/models/attendance_log/attendance_log_data.dart';
import 'package:eswm/models/attendance_log/attendance_logs_details.dart';
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

  static Future<List<AttendanceLogsDetails?>>? getDataAttendance(
      firstDate, lastDate) async {
    List<AttendanceLogsDetails?> filteredData = [];

    try {
      Response response = await Dio().get(
        '$theBase/attendance/history',
        queryParameters: {
          'date_from': firstDate,
          'date_to': lastDate,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer ${userInfo[1]}',
          },
        ),
      );

      if (response.statusCode == 200) {
        dynamic theData = response.data['data']['attendances'];

        if (theData != null && theData != []) {
          Map<String, dynamic> decode = json.decode(
            json.encode(response.data),
          );

          var convertData = AttendanceLogData.fromJson(decode);
          filteredData = convertData.data!.data;
        }
      }
    } on DioError catch (e) {
      print(e);
    }

    return filteredData;
  }
}
