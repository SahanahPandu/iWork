import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../utils/calendar/date.dart';
import '../http/error/api_error.dart';
import '../http/service/http_header.dart';
import '../http/service/http_service.dart';

class ENoticeApi {
  static updateENotice(BuildContext context) async {
    DateTime getTodayDate = DateTime.now();
    String currentDate = (selectedNewDate != "" && otherDate == true)
        ? selectedNewDate
        : Date.getTheDate(getTodayDate, '', "yyyy-MM-dd", null);
    FormData bodyData = FormData.fromMap({"leave_date": currentDate});
    try {
      Response response = await Dio().post(HttpService().updateEnotice,
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
