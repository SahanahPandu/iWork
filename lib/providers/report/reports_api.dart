// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eswm/providers/http/service/http_service.dart';
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

  static Future<ReportDetailsInfo?>? getDetailLaporan(
      BuildContext context, reportId) async {
    ReportDetailsInfo? theDetails;

    try {
      var response = await Dio().get(
        "$theBase/report",
        queryParameters: {
          "report_id": reportId,
        },
        options: HttpHeader.getApiHeader(userInfo[1]),
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
      ApiError.findDioError(e, context);
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

  static Future<List<ReportDetailsInfo>>? getDataLaporanDrawer(
      BuildContext context, passData) async {
    List<ReportDetailsInfo> filteredList = [];

    Map<String, dynamic> theParameters = {};

    if (passData != null) {
      var thePassData = Map<String, dynamic>.from(passData);

      //tarikh
      if (thePassData['date'] != "" && thePassData['date'] != null) {
        var convDate = Date.getTheDate(
            thePassData['date'], "dd/MM/yyyy", "yyyy-MM-dd", "ms");

        theParameters = {
          'date': convDate,
        };
      }

      //laluan
      if (thePassData['mainRoute'] != null || thePassData['mainRoute'] != "") {
        var theLaluan = {"main_route": thePassData['mainRoute']};
        theParameters.addEntries(theLaluan.entries);
      }

      //taman
      if (thePassData['parkId'] != null || thePassData['parkId'] != "") {
        var theTaman = {"park_pdibId": thePassData['parkId']};
        theParameters.addEntries(theTaman.entries);
      }

      //jalan
      if (thePassData['streetId'] != null || thePassData['streetId'] != "") {
        var theJalan = {"street_pdibId": thePassData['streetId']};
        theParameters.addEntries(theJalan.entries);
      }

      //obstacle
      if (thePassData['obstacle'] != null &&
          thePassData['obstacle'].isNotEmpty) {
        var obstacleList = thePassData['obstacle'];
        var obstacleIdList = [];
        obstacleList.forEach(
          (obstacle) {
            obstacleIdList.add(obstacle.id);
          },
        );

        var theListOfStatus = {"obstacle_type_id[]": obstacleIdList};
        theParameters.addEntries(theListOfStatus.entries);
      }

      //status
      if (thePassData['statusCode'] != null &&
          thePassData['statusCode'].isNotEmpty) {
        var statusList = thePassData['statusCode'];
        var statusCodeList = [];
        statusList.forEach(
          (status) {
            statusCodeList.add(status.code);
          },
        );

        var theListOfStatus = {"status_code[]": statusCodeList};
        theParameters.addEntries(theListOfStatus.entries);
      }
    }

    try {
      var response = await Dio().get(
        '$theBase/report/reports',
        queryParameters: theParameters,
        options: HttpHeader.getApiHeader(userInfo[1]),
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
      ApiError.findDioError(e, context);
    }

    return filteredList;
  }

  static Future<ReportPaging> fetchReportList(
      BuildContext context, int pageNumber,
      [Map<String, Object?>? passData]) async {
    String? getAccessToken = userInfo[1];
    dynamic reports;
    Map<String, dynamic> theParameters = {};
    if (passData != null) {
      var thePassData = Map<String, dynamic>.from(passData);

      //tarikh
      if (thePassData['date'] != "" && thePassData['date'] != null) {
        var convDate = Date.getTheDate(
            thePassData['date'], "dd/MM/yyyy", "yyyy-MM-dd", "ms");

        theParameters = {
          'date': convDate,
        };
      }

      //laluan
      if (thePassData['mainRoute'] != null || thePassData['mainRoute'] != "") {
        var theLaluan = {"main_route": thePassData['mainRoute']};
        theParameters.addEntries(theLaluan.entries);
      }

      //taman
      if (thePassData['parkId'] != null || thePassData['parkId'] != "") {
        var theTaman = {"park_pdibId": thePassData['parkId']};
        theParameters.addEntries(theTaman.entries);
      }

      //jalan
      if (thePassData['streetId'] != null || thePassData['streetId'] != "") {
        var theJalan = {"street_pdibId": thePassData['streetId']};
        theParameters.addEntries(theJalan.entries);
      }

      //obstacle
      if (thePassData['obstacle'] != null &&
          thePassData['obstacle'].isNotEmpty) {
        var obstacleList = thePassData['obstacle'];
        var obstacleIdList = [];
        obstacleList.forEach(
          (obstacle) {
            obstacleIdList.add(obstacle.id);
          },
        );

        var theListOfStatus = {"obstacle_type_id[]": obstacleIdList};
        theParameters.addEntries(theListOfStatus.entries);
      }

      //status
      if (thePassData['statusCode'] != null &&
          thePassData['statusCode'].isNotEmpty) {
        var statusList = thePassData['statusCode'];
        var statusCodeList = [];
        statusList.forEach(
          (status) {
            statusCodeList.add(status.code);
          },
        );

        var theListOfStatus = {"status_code[]": statusCodeList};
        theParameters.addEntries(theListOfStatus.entries);
      }
    }
    try {
      final response = await Dio().get(
          '$theBase/report/reports?page=$pageNumber',
          options: HttpHeader.getApiHeader(getAccessToken),
          queryParameters: theParameters);
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

  static updateReportForApproval(
      BuildContext context, int reportId, String status, String remark) async {
    // print("reportId: $reportId, status: $status, remark: $remark");
    FormData bodyData = FormData.fromMap(
        {"report_id": reportId, "status_code": status, "remarks": remark});
    try {
      Response response = await Dio().post(HttpService().updateReportApproveUrl,
          options: HttpHeader.getFormApiHeader(userInfo[1]), data: bodyData);
      if (response.statusCode == 200 && response.data != null) {
        return 'ok';
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return 'ng';
      }
      ApiError.findDioError(e, context);
    }
  }
}
