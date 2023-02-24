// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';

//import files
import 'package:eswm/models/cuti.dart';
import 'package:eswm/models/ecuti/ecuti_data.dart';
import 'package:eswm/models/ecuti/ecuti_details.dart';
import 'package:flutter/material.dart';

import '../config/config.dart';
import '../models/ecuti/ecuti_paging.dart';
import '../utils/calendar/date.dart';
import 'http/error/api_error.dart';
import 'http/service/http_header.dart';

class CutiApi {
  static Future<List<Cuti>> getCutiData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData = await assetBundle.loadString('assets/data/data_cuti.json');
    final data = json.decode(jsonData);

    return data.map<Cuti>(Cuti.fromJson).toList();
  }

  static Future<List<EcutiDetails?>>? getDataEcuti() async {
    List<EcutiDetails?> filterData = [];

    try {
      Response response = await Dio().get(
        '$theBase/attendance/ecuti',
        options: Options(headers: {
          'authorization': 'Bearer ${userInfo[1]}',
        }),
      );

      if (response.statusCode == 200) {
        dynamic theData = response.data['data']['data'];

        if (theData != null && theData != []) {
          Map<String, dynamic> decode = json.decode(
            json.encode(response.data),
          );

          var convertData = EcutiData.fromJson(decode);
          filterData = convertData.data!.data;
        }
      }
    } on DioError catch (e) {
      print(e);
    }

    return filterData;
  }

  /// App drawer - ECuti list (Used by Supervisor)
  static Future<EcutiPaging> fetchECutiList(
      BuildContext context, int pageNumber,
      [Map<String, Object?>? passData]) async {
    String? getAccessToken = userInfo[1];
    dynamic eCutis;
    // ignore: unused_local_variable
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
    }
    try {
      final response = await Dio().get(
          '$theBase/attendance/ecuti?page=$pageNumber',
          options: HttpHeader.getApiHeader(getAccessToken));
          //queryParameters: theParameters);
      if (response.statusCode == 200) {
        Map<String, dynamic> decode =
            json.decode(json.encode(response.data['data']));
        eCutis = EcutiPaging.fromJson(decode);
      } else {
        eCutis = [];
      }
    } on DioError catch (e) {
      ApiError.findDioError(e, context);
    }

    return eCutis;
  }
}
