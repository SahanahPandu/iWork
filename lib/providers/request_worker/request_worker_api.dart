import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../models/request_worker/list/request_worker.dart';
import '../http/error/api_error.dart';
import '../http/service/http_header.dart';
import '../http/service/http_service.dart';

class RequestWorkerApi {
  static Future<RequestWorker?> getRequestWorkerData(BuildContext context) async {
    RequestWorker? requestWorkerData;
    String getAccessToken = userInfo[1];

    try {
      Response response = await Dio().get(
        HttpService().loadRequestWorkerList,
        options: HttpHeader.getApiHeader(getAccessToken),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode = json.decode(json.encode(response.data));
        var convertData = RequestWorker.fromJson(decode);
        requestWorkerData = convertData;
      }
    } on DioError catch (e) {
      ApiError.findDioError(e, context);
      //print(e);
    }

    return requestWorkerData;
  }

  static updateRequestWorker(BuildContext context, var list) async {
    Map workerBody = {"worker_schedule": list};
    final jsonString = json.encode(workerBody);
    try {
      Response response = await Dio().post(
          HttpService().updateRequestWorkerUrl,
          options: HttpHeader.getJsonApiHeader(userInfo[1]),
          data: jsonString);

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
