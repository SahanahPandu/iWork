import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../models/attendance/worker_attendance/worker_attendance_verification.dart';
import '../http/error/api_error.dart';
import '../http/service/http_header.dart';
import '../http/service/http_service.dart';

class WorkerAttendanceVerificationApi {
  static Future<WorkerAttendanceVerification?> getWorkersAttendance(
      BuildContext context) async {
    WorkerAttendanceVerification? attendanceDetail;
    String getAccessToken = userInfo[1];

    try {
      Response response = await Dio().get(
        HttpService().loadWorkersAttendanceList,
        options: HttpHeader.getApiHeader(getAccessToken),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode = json.decode(json.encode(response.data));
        var convertData = WorkerAttendanceVerification.fromJson(decode);
        attendanceDetail = convertData;
      }
    } on DioError catch (e) {
      ApiError.findDioError(e, context);
      //print(e);
    }

    return attendanceDetail;
  }

  static updateWorkerAttendance(BuildContext context, var list) async {
    Map attendanceBody = {"worker": list};
    final jsonString = json.encode(attendanceBody);
    try {
      Response response = await Dio().post(
          HttpService().updateWorkerAttendanceUrl,
          options: HttpHeader.getJsonApiHeader(userInfo[1]),
          data: jsonString);

      if (response.statusCode == 200 && response.data != null) {
        return 'ok';
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return 'ng';
      }
      ApiError.findDioError(e, context);
    }
  }
}
