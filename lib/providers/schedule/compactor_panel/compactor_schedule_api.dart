import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//import files
import '../../../config/config.dart';
import '../../../models/schedule/compactor/detail/cp_schedule_detail.dart';
import '../../../models/schedule/compactor/list/schedule_list.dart';
import '../../../utils/calendar/date.dart';
import '../../http/error/api_error.dart';
import '../../http/service/http_header.dart';
import '../../http/service/http_service.dart';

class CompactorScheduleApi {
  /// App drawer - Schedule list (Used by Compactor panel, Supervisor)
  static Future<ScheduleList> fetchScheduleLists(
      BuildContext context, int pageNumber,
      [Map<String, Object>? passData]) async {
    String? getAccessToken = userInfo[1];
    dynamic myData =
        passData != null ? Map<String, dynamic>.from(passData) : null;
    dynamic convDate = "";
    dynamic statusList;
    dynamic schedules;
    List newStatusList = [];
    try {
      if (myData != null) {
        if (myData['filteredDate'] != "") {
          convDate = Date.getTheDate(
              myData['filteredDate'], "dd/MM/yyyy", "yyyy-MM-dd", "ms");
        }
        statusList = myData['selectedStatus'];
        if (statusList.length > 0) {
          for (int i = 0; i < statusList.length; i++) {
            newStatusList.add(statusList[i].code);
          }
        }
      }

      final response = await Dio().get(
          '$theBase/schedule/schedules?page=$pageNumber',
          options: HttpHeader.getApiHeader(getAccessToken),
          queryParameters:
              _getQueryParameter(passData, convDate, newStatusList));

      if (response.statusCode == 200) {
        Map<String, dynamic> decode = json.decode(json.encode(response.data));
        schedules = ScheduleList.fromJson(decode);
      } else {
        schedules = [];
      }
    } on DioError catch (e) {
      ApiError.findDioError(e, context);
    }

    return schedules;
  }

  static _getQueryParameter(
      Map<String, Object>? passData, String? convDate, dynamic status) {
    /// no passdata
    if (passData == null) {
      return null;
    }

    /// filtered date only
    else if (convDate != null && (status.length == 0 || status.isEmpty)) {
      return {'schedule_date': convDate};
    }

    /// filtered status only
    else if (convDate == null && (status.length >= 0 || status.isNotEmpty)) {
      return {
        'status_code[]': [status],
      };
    }

    /// filtered date and status
    else if (convDate != null && (status.length >= 0 || status.isNotEmpty)) {
      return {
        'schedule_date': convDate,
        'status_code[]': [status],
      };
    } else {
      return null;
    }
  }

  static Future<CScheduleDetail?> getCompactorScheduleDetail(
      BuildContext context, int id) async {
    CScheduleDetail? scheduleDetail;
    String getAccessToken = userInfo[1];

    try {
      Response response = await Dio().get(
        HttpService().loadScheduleDetailUrl,
        queryParameters: {'sc_main_id': id},
        options: HttpHeader.getApiHeader(getAccessToken),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode = json.decode(json.encode(response.data));

        var convertData = CScheduleDetail.fromJson(decode);

        scheduleDetail = convertData;
      }
    } on DioError catch (e) {
      ApiError.findDioError(e, context);
      //print(e);
    }

    return scheduleDetail;
  }
}
