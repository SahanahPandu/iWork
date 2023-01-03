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
String today = Date.getTheDate(getTodayDate.toString(), "yyyy-MM-dd", null);

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

    try {
      var response = await Dio().get(
        HttpService().loadCompactorTaskUrlTest,
        queryParameters: {'schedule_date': today},
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['data']['schedules'] != null) {
          Map<String, dynamic> decode = json.decode(json.encode(response.data));
          var convertData = CompactorTask.fromJson(decode).data!.schedules;
          decodeBody = convertData;
        }
      } else {
        //print("ERROR");
      }
    } catch (e) {
      //print(e);
    }
    return decodeBody;
  }

  static Future<CompactorTask> getCompactorScheduleData(
      BuildContext context) async {
    late CompactorTask dataSchedule;
    String? getAccessToken = userInfo[1];

    try {
      var response = await Dio().get(
        HttpService().loadCompactorTaskUrlTest,
        queryParameters: {'schedule_date': today},
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );
      Map<String, dynamic> decode = jsonDecode(jsonEncode(response.data));
      var convertData = CompactorTask.fromJson(decode);
      dataSchedule = convertData;
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return dataSchedule;
  }
}
