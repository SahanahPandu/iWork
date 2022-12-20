import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

//import files
import '../../config/config.dart';
import '../../models/task/compactor/compactor_task.dart';
import '../../models/task/compactor/data/schedules/schedule.dart';
import '../../utils/calendar/date.dart';
import '../http/service/http_service.dart';

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

  static Future<List<Schedule>>? getCompactorSchedule() async {
    List<Schedule> decodeBody = [];
    String getAccessToken = userInfo[1];

    try {
      var response = await Dio().get(
        HttpService().loadCompactorTaskUrlTest,
        queryParameters: {'schedule_date': '2022-12-13'},
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );

      if (response.statusCode == 200) {
        if (response.data['data']['schedules'] != null) {
          Map<String, dynamic> decode = json.decode(json.encode(response.data));
          var convertData = CompactorTask.fromJson(decode);
          decodeBody = convertData.data!.schedules;
        }
      } else {
        print ("ERROR");
      }
    } catch (e) {
      print(e);
    }
    return decodeBody;
  }
}
