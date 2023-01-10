// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eswm/models/report/report_list/report_paging.dart';

//import files
import '../models/report/report_details/report_details_data.dart';
import '../models/report/report_details/report_details_info.dart';
import '../models/reports.dart';
import 'package:eswm/config/config.dart';
import 'package:eswm/models/report/report_list/report_data.dart';
import 'package:eswm/models/report/report_list/report_details.dart';
import 'package:flutter/material.dart';

import '../utils/calendar/date.dart';

class ReportsApi {
  static Future<List<Reports>> getReportsData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_report.json');
    final data = json.decode(jsonData);

    return data.map<Reports>(Reports.fromJson).toList();
  }

  static Future<List<ReportDetails?>>? getDataLaporan(scMainId) async {
    List<ReportDetails?> decodeBody = [];
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

          decodeBody = convertData.data;
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
}
