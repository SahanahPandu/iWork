import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//import files
import '../../../config/config.dart';
import '../../../models/schedule/compactor/detail/schedule_detail.dart';
import '../../../models/schedule/compactor/list/data/schedule_data/schedule_data.dart';
import '../../../models/schedule/compactor/list/schedule_list.dart';
import '../../../utils/calendar/date.dart';
import '../../http/error/api_error.dart';
import '../../http/service/http_service.dart';

class CompactorScheduleApi {
  static Future<List<CScheduleData?>?> getCompactorScheduleListData(
      BuildContext context,
      [Map<String, Object>? passData]) async {
    List<CScheduleData?>? decodeBody;
    String? getAccessToken = userInfo[1];
    dynamic statusList;
    var myData = passData != null ? Map<String, dynamic>.from(passData) : null;
    var convDate = "";
    List newStatusList = [];

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

    try {
      var response = await Dio().get(
        HttpService().loadCompactorScheduleListUrl,
        //queryParameters: {'status_code[]': 'SBM', 'limit': 20},
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
        queryParameters: _getQueryParameter(passData, convDate, newStatusList),
      );
      if (response.statusCode == 200 && response.data != null) {
        if (response.data['data']['data'] != null &&
            response.data['data']['data'].length > 0) {
          Map<String, dynamic> decode = json.decode(json.encode(response.data));
          var convertData = ScheduleList.fromJson(decode).data!.data;
          nextPageUrl = ScheduleList.fromJson(decode).data!.nextPageUrl!;
          // linkList = ScheduleList.fromJson(decode).data!.links;
          // print("current page --> ${ScheduleList.fromJson(decode).data!.currentPage!}");
          // print("nextPageUrl --> $nextPageUrl");
          decodeBody = convertData;
        } else {
          decodeBody = [];
        }
      }
    } on DioError catch (e) {
      /// Checks for Dio returns error
      ApiError.findDioError(e, context);
    }
    return decodeBody;
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

  static Future<ScheduleList?> getCompactorScheduleList(
      BuildContext context, int id) async {
    ScheduleList? scheduleList;
    String getAccessToken = userInfo[1];

    try {
      // ignore: unused_local_variable
      Response response = await Dio().get(
        '$theBase/schedule',
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode = json.decode(json.encode(response.data));

        var convertData = ScheduleList.fromJson(decode);

        scheduleList = convertData;
      }
    } on DioError catch (e) {
      ApiError.findDioError(e, context);
      //print(e);
    }

    return scheduleList;
  }

  static Future<CScheduleDetail?> getCompactorScheduleDetail(
      BuildContext context, int id) async {
    CScheduleDetail? scheduleDetail;
    String getAccessToken = userInfo[1];

    try {
      // ignore: unused_local_variable
      Response response = await Dio().get(
        '$theBase/schedule',
        queryParameters: {'sc_main_id': id},
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode =
            json.decode(json.encode(response.data)); // decode the data from api

        var convertData = CScheduleDetail.fromJson(
            decode); // map the data with ScheduleData model, fromJson method do the task for mapping

        scheduleDetail =
            convertData; // only pass data list , list hold all data

      }
    } on DioError catch (e) {
      ApiError.findDioError(e, context);
      //print(e);
    }

    return scheduleDetail;
  }
}
