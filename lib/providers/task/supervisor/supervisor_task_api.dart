import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//import files
import '../../../config/config.dart';
import '../../../models/task/supervisor/supervisor_task.dart';
import '../../../utils/calendar/date.dart';
import '../../http/error/api_error.dart';
import '../../http/service/http_header.dart';
import '../../http/service/http_service.dart';

class SupervisorTaskApi {
  static Future<SupervisorTask> getSupervisorTaskData(
      BuildContext context) async {
    late SupervisorTask dataSchedule;
    String? getAccessToken = userInfo[1];
    DateTime getTodayDate = DateTime.now();
    String currentDate = (selectedNewDate != "" && otherDate == true)
        ? selectedNewDate
        : Date.getTheDate(getTodayDate, '', "yyyy-MM-dd", null);

    try {
      var response = await Dio().get(
        HttpService().loadSupervisorTaskUrl,
        queryParameters: {'schedule_date': currentDate},
        options: HttpHeader.getApiHeader(getAccessToken),
      );
      switch (response.statusCode) {
        case 200:
          if (response.data['data'] != null) {
            Map<String, dynamic> decode = jsonDecode(jsonEncode(response.data));
            var convertData = SupervisorTask.fromJson(decode);
            dataSchedule = convertData;
          } else {
            //print("No schedule data");
          }
          break;
        default:
        //print(response.statusCode);
      }
    } on DioError catch (e) {
      /// Checks for Dio returns error
      ApiError.findDioError(e, context);
    }

    return dataSchedule;
  }
}
