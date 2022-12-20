import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

//import files
import '../../config/config.dart';
import '../http/service/http_service.dart';

class LogoutApi {
  static Future<String> logoutUser() async {
    try {
      final response = await http.post(HttpService().logoutUrl,
          headers: {HttpHeaders.authorizationHeader: 'Bearer ${userInfo[1]}'});
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
