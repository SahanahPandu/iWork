import 'dart:convert';

import 'package:dio/dio.dart';

import '../config/config.dart';
import '../models/schedule/filter/schedule_filter.dart';
import '../models/schedule/filter/schedule_filter_data.dart';

class ScheduleFilterApi {
  static Future<ScheduleFilterData> getDataScheduleFilter(
      String namaLaluan, String namaSubLaluan, int idTaman) async {
    ScheduleFilterData fetchData = ScheduleFilterData(
      mainRoute: null,
      subRoutes: null,
      parks: null,
      streets: null,
      locations: null,
    );

    try {
      Response response = await Dio().get(
        '$theBase/schedule/route-filter',
        queryParameters: {
          'main_route': namaLaluan,
          'sub_route': namaSubLaluan,
          'park_id': idTaman,
        },
        options: Options(headers: {
          'authorization': 'Bearer ${userInfo[1]}',
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode =
            json.decode(json.encode(response.data)); // decode the data from api
        // print('Data decode: $decode');
        var convertData = ScheduleFilter.fromJson(
            decode); // map the data with ScheduleFilterData model, fromJson method do the task for mapping
        // print('Convert Data: $convertData');
        if (convertData.data != null) fetchData = convertData.data;

        // print('Fetch Data: $fetchData');
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return fetchData;
  }
}
