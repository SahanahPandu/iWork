import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eswm/models/schedule/schedule_data.dart';

//import files
import 'package:eswm/models/schedule/schedule_details.dart';

import '../config/config.dart';

class JadualApi {
  static Future<ScheduleDetails?>? getDataJadual(int id) async {
    ScheduleDetails? dataJadual;
    String getAccessToken = userInfo[1];

    try {
      // ignore: unused_local_variable
      Response response = await Dio().get(
        '$theBase/schedule',
        queryParameters: {'sc_main_id': id},
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode =
            json.decode(json.encode(response.data)); // decode the data from api

        var convertData = ScheduleData.fromJson(
            decode); // map the data with ScheduleData model, fromJson method do the task for mapping

        dataJadual =
            convertData.data; // only pass data list , list hold all data

      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return dataJadual;
  }
}
