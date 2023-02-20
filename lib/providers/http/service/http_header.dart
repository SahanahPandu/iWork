import 'package:dio/dio.dart';

class HttpHeader {
  static Options getApiHeader(String accessToken) {
    return Options(headers: {
      'authorization': 'Bearer $accessToken',
      'Accept': 'application/json'
    });
  }

  static Options getFormApiHeader(String accessToken) {
    return Options(headers: {
      'authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    });
  }

  static Options getJsonApiHeader(String accessToken) {
    return Options(headers: {
      'authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    });
  }
}
