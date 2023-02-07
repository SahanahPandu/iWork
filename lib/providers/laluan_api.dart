// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eswm/models/task/pra/general_worker_task.dart';
import 'package:eswm/models/task/pra/task_list.dart';
import 'package:flutter/material.dart';

//import files
import '../config/config.dart';
import '../models/laluan.dart';
import '../models/task/pra/task_data.dart';
import '../utils/calendar/date.dart';

DateTime getTodayDate = DateTime.now();
String today = Date.getTheDate(getTodayDate, '', "yyyy-MM-dd", null);

class LaluanApi {
  static Future<List<Laluan>> getLaluanData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_laluan.json');
    final data = json.decode(jsonData);

    return data.map<Laluan>(Laluan.fromJson).toList();
  }

  static Future<List<TaskList>>? getDataLaluan(selDate) async {
    print('Token: ${userInfo[1]}');
    List<TaskList> decodeBody = [];

    try {
      // ignore: unused_local_variable
      var response = await Dio().get(
        '$theBase/task/gw-list',
        queryParameters: {'schedule_date': selDate},
        options: Options(headers: {
          'authorization': 'Bearer ${userInfo[1]}',
        }),
      );

      if (response.statusCode == 200) {
        //checking task list null
        if (response.data['data']['list'] != null &&
            response.data['data']['list'] != []) {
          //get data for task list
          Map<String, dynamic> decode = json
              .decode(json.encode(response.data)); // decode the data from api
          var convertData = TaskData.fromJson(
              decode); // map the data with TaskData model, fromJson method do the task for mapping

          decodeBody =
              convertData.data.list; // only pass data list , list hold all data

        }
      }
    } catch (e) {
      print(e);
    }
    return decodeBody;
  }

  static Future<GeneralWorkerTask> getDataMasaKerja(context, selDate) async {
    GeneralWorkerTask theTime = const GeneralWorkerTask(
        startSchedule: null, stopSchedule: null, list: []);

    try {
      // ignore: unused_local_variable
      var response = await Dio().get(
        '$theBase/task/gw-list',
        queryParameters: {'schedule_date': selDate},
        options: Options(headers: {
          'authorization': 'Bearer ${userInfo[1]}',
        }),
      );

      if (response.statusCode == 200) {
        //checking task list null
        if (response.data['data'] != null) {
          Map<String, dynamic> decode = json.decode(json.encode(response.data));

          var convertData = TaskData.fromJson(decode);

          theTime = convertData.data;
        }
      }
    } on DioError catch (e) {
      print("The error: $e");
    }

    return theTime;
  }
}
