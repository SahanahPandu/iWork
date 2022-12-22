import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eswm/models/schedule/filter/schedule_filter_streets.dart';
import 'package:flutter/material.dart';

//import files
import '../config/config.dart';
import '../models/jalan.dart';
import '../models/schedule/filter/schedule_filter.dart';

class JalanApi {
  static Future<List<Jalan>> getJalanData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_jalan.json');
    final data = json.decode(jsonData);

    return data.map<Jalan>(Jalan.fromJson).toList();
  }

  static Future<List<ScheduleFilterStreets?>>? getDataJalan(int id) async {
    List<ScheduleFilterStreets> filterData = [];
    String getAccessToken = userInfo[1];

    try {
      Response response = await Dio().get(
        'http://103.26.46.187:81/api/schedule/route-filter',
        queryParameters: {'sc_main_id': id},
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode = json.decode(json.encode(response.data));
        var convertData = ScheduleFilter.fromJson(decode);
        filterData = convertData.data.streets;
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return filterData;
  }
}
