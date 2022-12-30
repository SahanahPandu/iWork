// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eswm/models/schedule/filter/schedule_filter_status.dart';
import 'package:eswm/models/schedule/schedule_data.dart';

//import files
import 'package:eswm/models/schedule/schedule_details.dart';

import '../config/config.dart';
import '../models/options/options_data.dart';

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
      print(e);
    }

    return dataJadual;
  }

  static Future<List<ScheduleFilterStatus?>?>? getDataStatusJadual() async {
    List<ScheduleFilterStatus?>? filterData = [];
    try {
      Response response = await Dio().get(
        '$theBase/options',
        queryParameters: {
          'fields[]': 'schedule_status',
        },
        options: Options(
          headers: {
            'authorization': 'Bearer ${userInfo[1]}',
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode =
            json.decode(json.encode(response.data)); // decode the data from api

        var convertData = OptionsData.fromJson(
            decode); // map the data with ScheduleFilter model, fromJson method do the task for mapping

        convertData.data?.scheduleStatus != null
            ? filterData = convertData.data!.scheduleStatus
            : filterData = [];
      }
    } on DioError catch (e) {
      print(e);
    }

    return filterData;
  }
}
