import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../http/error/api_error.dart';
import '../http/service/http_header.dart';
import '../http/service/http_service.dart';

class TrackLocationApi {
  static updateVehicleLocation(
      BuildContext context, var positionList, String vehicleNo) async {
    FormData bodyData = FormData.fromMap(
        {"locations": json.encode(positionList), "vehicle_no": vehicleNo});
    try {
      Response response = await Dio().post(HttpService().updateLocationUrl,
          options: HttpHeader.getFormApiHeader(userInfo[1]), data: bodyData);
      if (response.statusCode == 200 && response.data != null) {
        return 'ok';
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return 'ng';
      }
      ApiError.findDioError(e, context, false);
    }
  }
}
