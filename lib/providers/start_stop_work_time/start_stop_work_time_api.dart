import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../../models/start_stop_work_time/start_stop_work_time.dart';
import '../http/service/http_service.dart';

class StartStopWorkApi {
  static Future<String> uploadStartWorkTime(
    int? scMain,
  ) async {
    late String startTime;
    String getAccessToken = userInfo[1];
    final data = {'sc_main_id': scMain.toString()};
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $getAccessToken'};
    final response = await http.post(HttpService().updateStartWorkTime,
        headers: headers, body: data);
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> decode = jsonDecode(response.body);
        //logDev.log(decode.toString(), name: "myResponseLog");
        StartStopWorkTime convertData = StartStopWorkTime.fromJson(decode);
        startTime = convertData.status.toString();
        switch (startTime) {
          case 'Success':
            // return convertData.data.toString();
            return 'ok';
          default:
            return 'ng';
        }
      case 401:
        return 'ng';
      case 404:
        return 'not_found';
      default:
        return 'error';
    }
  }

  static Future<String> uploadStopWorkTime(
    int? scMain,
  ) async {
    late String stopTime;
    String getAccessToken = userInfo[1];
    final data = {'sc_main_id': scMain.toString()};
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $getAccessToken'};
    final response = await http.post(HttpService().updateStopWorkTime,
        headers: headers, body: data);
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> decode = jsonDecode(response.body);
        //logDev.log(decode.toString(), name: "myResponseLog");
        StartStopWorkTime convertData = StartStopWorkTime.fromJson(decode);
        stopTime = convertData.status.toString();
        switch (stopTime) {
          case 'Success':
            // return convertData.data.toString();
            return 'ok';
          default:
            return 'ng';
        }
      case 401:
        return 'ng';
      case 404:
        return 'not_found';
      default:
        return 'error';
    }
  }
}
