import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

//import files
import '../../models/user/error/login_error.dart';
import '../../models/user/user.dart';
import '../../utils/authentication/auth.dart';
import '../http/service/http_service.dart';

class LoginApi {
  static Future<String> authenticateUser(String loginId, String password,
      String userIdType, String deviceInfo) async {
    try {
      final response = await http.post(HttpService().loginUrl, headers: {
        HttpHeaders.authorizationHeader: ''
      }, body: {
        'login_id': loginId,
        'password': password,
        'user_type_id': userIdType,
        'device_info_1': deviceInfo
      });
      switch (response.statusCode) {

        /// Http Response : login success
        case 200:
          var decodeUserData =
              User.fromJson(json.decode(response.body)).data.userData;
          if (decodeUserData.canLogin == 1) {
            if (decodeUserData.accessToken != '' &&
                User.fromJson(json.decode(response.body)).message ==
                    "Successfully Login!") {
              Auth.setUserInfo(decodeUserData);
              return 'ok';
            } else if (decodeUserData.accessToken == "") {
              return 'token_ng';
            }
          } else {
            return 'ng';
          }
          return 'ng';

        /// Http Response : credential error
        case 401:
          if (LoginError.fromJson(json.decode(response.body)).message ==
              "Unauthorized") {
            return 'device_ng';
          } else if (LoginError.fromJson(json.decode(response.body)).message ==
              "Invalid Credentials") {
            return 'wrong';
          }
          return 'wrong';

        /// Http Response : validation error (like form validation, datatype errors)
        case 422:
          return 'wrong';

        /// Http Response : Bad request, server error and others
        default:
          return 'ng';
      }
    } on SocketException {
      //print("Connection error.Please retry ");
      return 'error';
    }
  }
}
