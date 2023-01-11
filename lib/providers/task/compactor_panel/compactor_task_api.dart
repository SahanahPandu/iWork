import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//import files
import '../../../config/config.dart';
import '../../../models/task/compactor/compactor_task.dart';
import '../../../models/task/compactor/data/schedule/schedule.dart';
import '../../../utils/calendar/date.dart';
import '../../http/service/http_service.dart';

DateTime getTodayDate = DateTime.now();
String currentDate = (selectedNewDate != "" && otherDate == true)
    ? selectedNewDate
    : Date.getTheDate(getTodayDate, '', "yyyy-MM-dd", null);

class CompactorTaskApi {
  static Future<String> loadCompactorTask() async {
    try {
      final response = await http.post(HttpService().loadCompactorTaskUrl,
          headers: {HttpHeaders.authorizationHeader: 'Bearer ${userInfo[1]}'});
      switch (response.statusCode) {
        case 200:
          /* var decodeTaskData =
              CompactorTask.fromJson(json.decode(response.body))
                  .data
                  ?.schedules[0];*/
          return 'ok';
        case 401:
          //print("Unauthenticated!");
          return 'ng';
        default:
          return 'ng';
      }
    } on SocketException {
      //print("Connection error.Please retry ");
      return 'error';
    }
  }

  static Future<List<Schedule>?> getCompactorScheduleList() async {
    List<Schedule>? decodeBody = [];
    String? getAccessToken = userInfo[1];
    DateTime getTodayDate = DateTime.now();
    String currentDate = (selectedNewDate != "" && otherDate == true)
        ? selectedNewDate
        : Date.getTheDate(getTodayDate, '', "yyyy-MM-dd", null);
    try {
      var response = await Dio().get(
        HttpService().loadCompactorTaskUrlTest,
        queryParameters: {'schedule_date': currentDate},
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['data']['schedules'] != null) {
          Map<String, dynamic> decode = json.decode(json.encode(response.data));
          var convertData = CompactorTask.fromJson(decode).data!.schedules;

          decodeBody = convertData;
        } else {
          //print("No schedule data");
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        if (e.response!.statusMessage == "Unauthenticated") {
          //print("status message --> ${e.response!.statusMessage}");
        } else {
          //print("status message --> ${e.response!.statusMessage}");
        }
      } else {
        //print("status statusCode --> ${e.response!.statusCode}");
      }
    }
    return decodeBody;
  }

  static Future<CompactorTask> getCompactorScheduleData(
      BuildContext context) async {
    late CompactorTask dataSchedule;
    String? getAccessToken = userInfo[1];

    DateTime getTodayDate = DateTime.now();
    String currentDate = (selectedNewDate != "" && otherDate == true)
        ? selectedNewDate
        : Date.getTheDate(getTodayDate, '', "yyyy-MM-dd", null);
    try {
      var response = await Dio().get(
        HttpService().loadCompactorTaskUrlTest,
        queryParameters: {'schedule_date': currentDate},
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );
      switch (response.statusCode) {
        case 200:
          if (response.data['data']['schedules'] != null) {
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
      //handle DioError here by error type or by error code
      if (e.response!.statusCode == 401) {
        if (e.response!.statusMessage == "Unauthenticated") {
          //print("status message --> ${e.response!.statusMessage}");
        } else {
          //print("status message --> ${e.response!.statusMessage}");
        }
      } else {
        //print("status statusCode --> ${e.response!.statusCode}");
      }
    }

    return dataSchedule;
  }
}
