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
String today = Date.getTheDate(getTodayDate.toString(), "yyyy-MM-dd", null);

class LaluanApi {
  static Future<List<Laluan>> getLaluanData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_laluan.json');
    final data = json.decode(jsonData);

    return data.map<Laluan>(Laluan.fromJson).toList();
  }

  static Future<List<TaskList>>? getDataLaluan() async {
    List<TaskList> decodeBody = [];
    String getAccessToken = userInfo[1];

    try {
      // ignore: unused_local_variable
      var response = await Dio().get(
        'http://103.26.46.187:81/api/task/gw-list',
        queryParameters: {'schedule_date': today},
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );

      if (response.statusCode == 200) {
        //checking task list null
        if (response.data['data']['list'] != null) {
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

  static Future<GeneralWorkerTask> getDataMasaKerja(context) async {
    late GeneralWorkerTask theTime;
    String getAccessToken = userInfo[1];
    print('Token: $getAccessToken');

    try {
      // ignore: unused_local_variable
      var response = await Dio().get(
        'http://103.26.46.187:81/api/task/gw-list',
        queryParameters: {'schedule_date': today},
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
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
    } catch (e) {
      print(e);
    }

    return theTime;
  }
}
