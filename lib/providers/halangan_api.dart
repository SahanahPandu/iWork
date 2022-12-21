import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eswm/config/config.dart';
import 'package:eswm/models/options/options_data.dart';
import 'package:eswm/models/report/obstacle_types.dart';
import 'package:flutter/material.dart';

//import files
import 'package:eswm/models/halangan.dart';

class HalanganApi {
  static Future<List<Halangan>> getHalanganData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_jenis_halangan.json');
    final data = json.decode(jsonData);

    return data.map<Halangan>(Halangan.fromJson).toList();
  }

  static Future<List<ObstacleTypes?>?>? getDataJenisHalangan() async {
    List<ObstacleTypes?>? filterData = [];

    try {
      Response response = await Dio().get(
        'http://10.0.2.2:8000/api/options',
        queryParameters: {
          'fields[]': 'obstacle_types',
        },
        options: Options(headers: {
          'authorization': 'Bearer ${userInfo[1]}',
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode =
            json.decode(json.encode(response.data)); // decode the data from api

        var convertData = OptionsData.fromJson(
            decode); // map the data with ScheduleFilter model, fromJson method do the task for mapping

        convertData.data?.obtacleTypes != null
            ? filterData = convertData.data!.obtacleTypes
            : filterData = [];
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return filterData;
  }
}
