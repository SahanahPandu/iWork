// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../models/options/options_data.dart';
import '../../models/report/report_details/report_details_data.dart';
import '../../models/report/report_details/report_details_info.dart';
import '../../models/report/report_list/report_data.dart';
import '../../models/report/report_list/report_paging.dart';
import '../../models/report/report_status.dart';
import '../../models/reports.dart';
import '../../utils/calendar/date.dart';
import '../http/error/api_error.dart';
import '../http/service/http_header.dart';

class ReportsApi {
  static Future<List<Reports>> getReportsData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_report.json');
    final data = json.decode(jsonData);

    return data.map<Reports>(Reports.fromJson).toList();
  }

  static Future<List<ReportDetailsInfo?>>? getDataLaporan(scMainId) async {
    List<ReportDetailsInfo?> decodeBody = [];
    String getAccessToken = userInfo[1];

    try {
      var response = await Dio().get(
        '$theBase/report/schedule',
        queryParameters: {
          'sc_main_id': scMainId,
        },
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );

      if (response.statusCode == 200) {
        dynamic theData = response.data['data']['reports'];

        if (theData != null && theData != []) {
          Map<String, dynamic> decode = json.decode(
            json.encode(response.data),
          );

          var convertData = ReportData.fromJson(decode);

          decodeBody = convertData.data!;
        }
      }
    } on DioError catch (e) {
      print(e);
    }

    return decodeBody;
  }

  static Future<ReportDetailsInfo?>? getDetailLaporan(reportId) async {
    ReportDetailsInfo? theDetails;

    try {
      var response = await Dio().get(
        "$theBase/report",
        queryParameters: {
          "report_id": reportId,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer ${userInfo[1]}',
          },
        ),
      );

      if (response.statusCode == 200) {
        dynamic theData = response.data['data']['reports'];

        if (theData != null && theData != []) {
          Map<String, dynamic> decode = json.decode(
            json.encode(response.data),
          );

          var convertData = ReportDetailsData.fromJson(decode);

          theDetails = convertData.data;
        }
      }
    } on DioError catch (e) {
      print(e);
    }

    return theDetails;
  }

  static Future<List<ReportStatus?>?> getStatusLaporan() async {
    List<ReportStatus?>? filterData = [];

    try {
      var response = await Dio().get(
        "$theBase/options",
        queryParameters: {
          "fields[]": "report_status",
        },
        options: Options(
          headers: {
            'authorization': 'Bearer ${userInfo[1]}',
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data != null && response.data != []) {
          Map<String, dynamic> decode = json.decode(
            json.encode(response.data),
          );

          var convertData = OptionsData.fromJson(decode);

          convertData.data?.reportStatus != null
              ? filterData = convertData.data!.reportStatus
              : filterData = [];
        }
      }
    } on DioError catch (e) {
      print(e);
    }

    return filterData;
  }

  static Future<List<ReportDetailsInfo>>? getDataLaporanDrawer(passData) async {
    List<ReportDetailsInfo> filteredList = [];

    var thePassData = Map<String, dynamic>.from(passData);

    var passDate = "";
    if (thePassData['date'] != "") {
      passDate = Date.getTheDate(
          thePassData['date'], "dd/MM/yyyy", "yyyy-MM-dd", "ms");
    }

    try {
      var response = await Dio().get(
        '$theBase/report/reports',
        queryParameters: {
          'date': passDate,
          'main_route': thePassData['mainRoute'],
          'park_pdibId': thePassData['parkId'],
          'street_pdibId': thePassData['streetId'],
          'status_code': thePassData['statusCode'],
        },
        options: Options(headers: {
          'authorization': 'Bearer ${userInfo[1]}',
        }),
      );

      if (response.statusCode == 200) {
        if (response.data['data']['data'] != null &&
            response.data['data']['data'] != []) {
          Map<String, dynamic> decode = json.decode(
            json.encode(response.data['data']),
          );

          var convertData = ReportPaging.fromJson(decode);
          filteredList = convertData.data;
        }
      }
    } on DioError catch (e) {
      print(e);
    }

    return filteredList;
  }

  static Future<ReportPaging> fetchReportList(
      BuildContext context, int pageNumber,
      [Map<String, Object>? passData]) async {
    String? getAccessToken = userInfo[1];
    String mainRoute = "";
    dynamic convDate = "";
    //dynamic statusList;
    dynamic reports;
    dynamic myData =
        passData != null ? Map<String, dynamic>.from(passData) : null;

    List newStatusList = [];
    try {
      if (myData != null) {
        if (myData['mainRoute'] != "") {
          mainRoute = myData['mainRoute'];
        }
        /*if (myData['filteredDate'] != "") {
          convDate = Date.getTheDate(
              myData['filteredDate'], "dd/MM/yyyy", "yyyy-MM-dd", "ms");
        }

        statusList = myData['selectedStatus'];
        if (statusList.length > 0) {
          for (int i = 0; i < statusList.length; i++) {
            newStatusList.add(statusList[i].code);
          }
        }*/
      }
      final response = await Dio().get(
          '$theBase/report/reports?page=$pageNumber',
          options: HttpHeader.getApiHeader(getAccessToken),
          queryParameters:
              _getQueryParameter(passData, mainRoute, convDate, newStatusList));
      if (response.statusCode == 200) {
        Map<String, dynamic> decode =
            json.decode(json.encode(response.data['data']));
        reports = ReportPaging.fromJson(decode);
      } else {
        reports = [];
      }
    } on DioError catch (e) {
      ApiError.findDioError(e, context);
    }

    return reports;
  }

  static _getQueryParameter(Map<String, Object>? passData, String? route,
      String? convDate, dynamic status) {
    /// no passdata
    if (passData == null) {
      return null;
    }

    /// filtered main route only
    else if (route != null &&
        (convDate == null && status.length == 0 || status.isEmpty)) {
      return {'main_route': route};
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
}
