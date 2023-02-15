import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eswm/models/vc/confirmation/vc_verification_list.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../../http/error/api_error.dart';
import '../../http/service/http_header.dart';
import '../../http/service/http_service.dart';

class VehicleChecklistVerificationApi {

  static Future<List<ChecklistList>?> getVehicleChecklistVerificationList(
      BuildContext context, String date) async {
    String? getAccessToken = userInfo[1];
    List<ChecklistList>? vcList;
    try {
      final response = await Dio().get(
          HttpService().loadVehicleChecklistVerificationList,
          queryParameters: {'schedule_date': date},
          options: HttpHeader.getApiHeader(getAccessToken));

      if (response.statusCode == 200) {
        Map<String, dynamic> decode = json.decode(json.encode(response.data));
        vcList = VCVerificationList.fromJson(decode).data.checklist;
      }
    } on DioError catch (e) {
      ApiError.findDioError(e, context);
    }

    return vcList;
  }
}
