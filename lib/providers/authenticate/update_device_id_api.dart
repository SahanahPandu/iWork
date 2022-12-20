import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../http/service/http_service.dart';

class UpdateDeviceIdApi {
  static Future<String> updateDeviceId(
      String id, String newDeviceId, String userType) async {
    try {
      final response = await http.post(HttpService().updateIDUrl, body: {
        'login_id': id,
        'device_info_1': newDeviceId,
        'user_type_id': userType
      });
      switch (response.statusCode) {
        case 200:
          return 'ok';
        case 401:
          return 'ng';
        default:
          return 'ng';
      }
    } on SocketException {
      //print("Connection error.Please retry ");
      return 'error';
    }
  }
}
