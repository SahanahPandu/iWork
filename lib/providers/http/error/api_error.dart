import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//import files
import '../../../config/config.dart';
import '../../../utils/authentication/auth.dart';
import '../../../widgets/alert/toast.dart';

class ApiError {
  static findDioError(DioError e, BuildContext context) {
    String message = "Issue: ";

    /// Checks for Dio returns error
    /// Connection Error 1.No Internet Connection/Socket could not be established/Could not send request
    if (e.type == DioErrorType.other) {
      dioError.value = 1;
      message = "Tiada sambungan internet";

      ///"SocketException: No route to host (OS Error: No route to host, errno = 113), address = iworkapi.swmsb.com"
      ///"SocketException: Connection refused (OS Error: Connection refused, errno = 111), address = iworkapi.swmsb.com
      if (e.message.contains(
              "SocketException: Connection refused (OS Error: Connection refused") ||
          e.message.contains(
              "SocketException: No route to host (OS Error: No route to host")) {
        dioError.value = 10;
        message = "Server mengalami masalah. Sila hubungi IT";
      }
    }

    /// Connection Error 2.Connection Timeout
    else if (e.type == DioErrorType.connectTimeout) {
      dioError.value = 2;
      message = "Masalah sambungan internet";
    }

    /// Connection Error 3.Receive Timeout
    else if (e.type == DioErrorType.receiveTimeout) {
      dioError.value = 3;
      message = "Masalah sambungan internet";
    } else if (e.type == DioErrorType.response) {
      /// Client Error Response 4. 400: Bad Request
      if (e.response!.statusCode == 400) {
        dioError.value = 4;
        message = "Masalah sambungan internet";
      }

      /// Client Error Response 5. 401: Token expired/invalid/unauthenticated
      else if (e.response!.statusCode == 401) {
        if (e.response!.statusMessage == "Unauthorized") {
          dioError.value = 5;
          message = "Tamat tempoh akses. Sila log masuk semula";
          Auth.clearUserData(context);
        }
      }

      /// Client Error Response 6. 404: Not found/URL is not recognized
      else if (e.response!.statusCode == 402) {
        dioError.value = 6;
        message = "Masalah sambungan internet";
      }

      /// Client Error Response 7. 405: Method not found
      else if (e.response!.statusCode == 405) {
        dioError.value = 7;
        message = "Masalah server";
      }

      /// Client Error Response 8. 500: Internal Server Error
      else if (e.response!.statusCode == 500) {
        dioError.value = 8;
        message = "Masalah server";
      }

      /// Client Error Response 9. 502: Bad Getaway
      else if (e.response!.statusCode == 502) {
        dioError.value = 9;
        message = "Masalah server";
      } else {
        message = message + e.message;
      }
    } else {
      message = message + e.message;
    }
    showErrorToast(context, message);
  }
}
