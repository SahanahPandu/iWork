import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eswm/models/schedule/filter/schedule_filter_parks.dart';
import 'package:flutter/material.dart';

//import files
import '../config/config.dart';
import '../models/schedule/filter/schedule_filter.dart';
import '../models/taman.dart';

class TamanApi {
  static Future<List<Taman>> getTamanData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_taman.json');
    final data = json.decode(jsonData);

    return data.map<Taman>(Taman.fromJson).toList();
  }

  static Future<List<ScheduleFilterParks?>>? getDataTaman(scMainId) async {
    List<ScheduleFilterParks?> filterData = [];
    String getAccessToken = userInfo[1];
    // print('ID: $scMainId');

    try {
      Response response = await Dio().get(
        '$theBase/schedule/route-filter',
        queryParameters: {'sc_main_id': scMainId},
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode = json.decode(json.encode(response.data));
        var convertData = ScheduleFilter.fromJson(decode);
        filterData = convertData.data.parks;
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return filterData;
  }
}
