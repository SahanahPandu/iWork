import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

//import files
import '../../models/user/user.dart';
import '../http/error/api_error.dart';
import '../http/response/api_response.dart';
import '../http/service/http_service.dart';

class LoginApi {
  static Future<ApiResponse> authenticateUser(String loginId, String password,
      String userIdType, String deviceInfo) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await http.post(HttpService().loginUrl, body: {
        'login_id': loginId,
        'password': password,
        'user_type_id': userIdType,
        'device_info_1': deviceInfo
      });
      print(response.statusCode);
      print(response.body);
      switch (response.statusCode) {
        case 200:
          print(userFromJson(response.body).message);
          apiResponse.data = User.fromJson(json.decode(response.body)).message;
          break;
        case 401:
          apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
          break;
        default:
          apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
          break;
      }
    } on SocketException {
      apiResponse.apiError = ApiError(error: "Server error. Please retry");
    }
    return apiResponse;
  }
}
