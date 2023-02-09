import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//import files
import '../../../config/config.dart';
import '../../../models/schedule/supervisor/detail/sv_schedule_detail.dart';
import '../../http/error/api_error.dart';
import '../../http/service/http_header.dart';
import '../../http/service/http_service.dart';

class SupervisorScheduleApi {
  static Future<SupervisorScheduleDetail?> getSupervisorScheduleDetail(
      BuildContext context, int id) async {
    SupervisorScheduleDetail? scheduleDetail;
    String getAccessToken = userInfo[1];

    try {
      Response response = await Dio().get(
        HttpService().loadScheduleDetailUrl,
        queryParameters: {'sc_main_id': id},
        options: HttpHeader.getApiHeader(getAccessToken),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode = json.decode(json.encode(response.data));

        var convertData = SupervisorScheduleDetail.fromJson(decode);

        scheduleDetail = convertData;
      }
    } on DioError catch (e) {
      ApiError.findDioError(e, context);
      //print(e);
    }

    return scheduleDetail;
  }
}
