// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eswm/models/ecuti/ecuti_data.dart';
import 'package:eswm/models/ecuti/ecuti_details.dart';
import 'package:flutter/material.dart';

//import files
import 'package:eswm/models/cuti.dart';

import '../config/config.dart';

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
        'http://103.26.46.187:81/api/attendance/ecuti',
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
}
