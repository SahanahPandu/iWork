import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eswm/models/report/report_schedule/report_of_schedule.dart';
import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../http/error/api_error.dart';
import '../http/service/http_header.dart';
import '../http/service/http_service.dart';

class ReportOfScheduleApi {
  static Future<ReportOfSchedule?> getReportsOfSchedule(
      BuildContext context, int scId) async {
    ReportOfSchedule? reportDetail;
    String getAccessToken = userInfo[1];

    try {
      Response response = await Dio().get(
        HttpService().loadReportOfScheduleList,
        options: HttpHeader.getApiHeader(getAccessToken),
        queryParameters: {'sc_main_id': scId},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode = json.decode(json.encode(response.data));
        var convertData = ReportOfSchedule.fromJson(decode);
        reportDetail = convertData;
      }
    } on DioError catch (e) {
      ApiError.findDioError(e, context);
      //print(e);
    }

    return reportDetail;
  }
}
