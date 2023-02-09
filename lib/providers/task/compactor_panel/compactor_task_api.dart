import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//import files
import '../../../config/config.dart';
import '../../../models/task/compactor/compactor_task.dart';
import '../../../models/task/compactor/data/data.dart';
import '../../../models/task/compactor/data/schedule/schedule.dart';
import '../../../utils/calendar/date.dart';
import '../../http/error/api_error.dart';
import '../../http/service/http_header.dart';
import '../../http/service/http_service.dart';

DateTime getTodayDate = DateTime.now();
String currentDate = (selectedNewDate != "" && otherDate == true)
    ? selectedNewDate
    : Date.getTheDate(getTodayDate, '', "yyyy-MM-dd", null);

class CompactorTaskApi {
  static Future<List<Schedule?>?> getCompactorTaskList(
      BuildContext context) async {
    List<Schedule?>? decodeBody = [];
    String? getAccessToken = userInfo[1];
    DateTime getTodayDate = DateTime.now();
    String currentDate = (selectedNewDate != "" && otherDate == true)
        ? selectedNewDate
        : Date.getTheDate(getTodayDate, '', "yyyy-MM-dd", null);
    try {
      var response = await Dio().get(
        HttpService().loadCompactorTaskUrlTest,
        queryParameters: {'schedule_date': currentDate},
        options: HttpHeader.getApiHeader(getAccessToken),
      );

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['data']['schedules'] != null) {
          Map<String, dynamic> decode = json.decode(json.encode(response.data));
          var convertData = CompactorTask.fromJson(decode).data.schedules;

          decodeBody = convertData;
        } else {
          //print("No schedule data");
        }
      }
    } on DioError catch (e) {
      /// Checks for Dio returns error
      ApiError.findDioError(e, context);
    }
    return decodeBody;
  }

  static Future<CompactorTask> getCompactorTaskData(
      BuildContext context) async {
    CompactorTask dataSchedule = CompactorTask(data: Data(), status: "");
    String? getAccessToken = userInfo[1];

    DateTime getTodayDate = DateTime.now();
    String currentDate = (selectedNewDate != "" && otherDate == true)
        ? selectedNewDate
        : Date.getTheDate(getTodayDate, '', "yyyy-MM-dd", null);
    try {
      var response = await Dio().get(
        HttpService().loadCompactorTaskUrlTest,
        queryParameters: {'schedule_date': currentDate},
        options: HttpHeader.getApiHeader(getAccessToken),
      );
      switch (response.statusCode) {
        case 200:
          if (response.data['data'] != null) {
            Map<String, dynamic> decode = jsonDecode(jsonEncode(response.data));
            var convertData = CompactorTask.fromJson(decode);
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
