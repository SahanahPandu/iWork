import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//import files
import '../config/config.dart';
import '../models/schedule/filter/schedule_filter.dart';
import '../models/schedule/filter/schedule_filter_sub_routes.dart';
import '../models/sub_laluan.dart';

class SubLaluanApi {
  static Future<List<SubLaluan>> getSubLaluanData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_sub_laluan.json');
    final data = json.decode(jsonData);

    return data.map<SubLaluan>(SubLaluan.fromJson).toList();
  }

  static Future<List<ScheduleFilterSubRoutes?>>? getDataSubLaluan(
      scMainId) async {
    List<ScheduleFilterSubRoutes?> filterData = [];
    String getAccessToken = userInfo[1];

    try {
      Response response = await Dio().get(
        '$theBase/schedule/route-filter',
        queryParameters: {
          'sc_main_id': scMainId,
        },
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode =
            json.decode(json.encode(response.data)); // decode the data from api
        // print('Data decode: $decode');
        var convertData = ScheduleFilter.fromJson(
            decode); // map the data with ScheduleFilter model, fromJson method do the task for mapping

        convertData.data.subRoutes != null
            ? filterData = convertData.data.subRoutes
            : filterData = []; // only pass data list , list hold all data

      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return filterData;
  }
}
