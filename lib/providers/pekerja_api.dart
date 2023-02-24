import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//import files
import '../config/config.dart';
import '../models/employee/employee.dart';
import '../models/employee/supervisor.dart';
import '../models/pekerja.dart';
import '../models/user/user_data.dart';

class PekerjaApi {
  static Future<List<Pekerja>> getPekerjaData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_pekerja.json');
    final data = json.decode(jsonData);

    return data.map<Pekerja>(Pekerja.fromJson).toList();
  }

  static Future<List<UserData>> getDataSenaraiPekerja(passData) async {
    List<UserData> employeeList = [];
    //Filtering based on filtered schedule main id and list of svId
    Map<String, dynamic> theParameters = {};

    if (passData != null) {
      var theData = Map<String, dynamic>.from(passData);

      if (theData['scMainId'] != "") {
        theParameters = {
          'sc_main_id': theData['scMainId'],
        };
      }

      if (theData['svIdList'] != null && theData['svIdList'].isNotEmpty) {
        var svList = theData['svIdList'];
        var svIdList = [];

        svIdList.add(userInfo[5]); // add current login sv id
        svList.forEach(
          (svId) {
            svIdList.add(svId);
          },
        );

        var theListOfSV = {"supervisor_id[]": svIdList};
        theParameters.addEntries(theListOfSV.entries);
      } else {
        var theSVID = {"supervisor_id[]": userInfo[5]};
        theParameters.addAll(theSVID);
      }
    }

    try {
      var response = await Dio().get(
        '$theBase/task/workers',
        queryParameters: theParameters,
        options: Options(headers: {
          'authorization': 'Bearer ${userInfo[1]}',
        }),
      );

      if (response.statusCode == 200) {
        //check the data is null or not
        if (response.data['data']['workers'] != null &&
            response.data['data']['workers'] != []) {
          Map<String, dynamic> decode = json.decode(
            json.encode(response.data),
          );

          var convertData = Employee.fromJson(decode);
          employeeList = convertData.data;
        }
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return employeeList;
  }

  static Future<List<UserData>> getDataSenaraiPenyelia() async {
    List<UserData> svList = [];

    try {
      var response = await Dio().get(
        '$theBase/task/supervisors',
        options: Options(headers: {
          'authorization': 'Bearer ${userInfo[1]}',
        }),
      );

      if (response.statusCode == 200) {
        //check the data is null or not
        if (response.data['data']['supervisors'] != null &&
            response.data['data']['supervisors'] != []) {
          Map<String, dynamic> decode = json.decode(
            json.encode(response.data),
          );

          var convertData = Supervisor.fromJson(decode);
          svList = convertData.data;
        }
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return svList;
  }
}
