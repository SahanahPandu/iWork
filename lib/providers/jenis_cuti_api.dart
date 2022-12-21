// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eswm/models/ecuti/leave_types.dart';
import 'package:eswm/models/options/options_data.dart';
import 'package:flutter/material.dart';

//import files
import 'package:eswm/models/jenis_cuti.dart';

import '../config/config.dart';

class JenisCutiApi {
  static Future<List<JenisCuti>> getJenisCutiData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_jenis_cuti.json');
    final data = json.decode(jsonData);

    return data.map<JenisCuti>(JenisCuti.fromJson).toList();
  }

  static Future<List<LeaveTypes?>?>? getDataJenisCuti() async {
    List<LeaveTypes?>? filterData = [];

    try {
      Response response = await Dio().get(
        'http://10.0.2.2:8000/api/options',
        queryParameters: {
          'fields[]': 'leave_types',
        },
        options: Options(headers: {
          'authorization': 'Bearer ${userInfo[1]}',
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode =
            json.decode(json.encode(response.data)); //decode data from api

        var convertData = OptionsData.fromJson(decode);

        convertData.data?.leaveTypes != null
            ? filterData = convertData.data!.leaveTypes
            : filterData = [];
      }
    } on DioError catch (e) {
      print(e);
    }

    return filterData;
  }
}
