import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpClient {
  static const int httpCodeSuccess = 200;
  static const int connectTimeout = 10000;

  static Future<String?> get(String path) async {
    var options = BaseOptions(
      contentType: Headers.jsonContentType,
      connectTimeout: connectTimeout,
    );
    var dio = build(options);
    var response = await dio.get(path);
    return convertResponseToString(response);
  }

  static Dio build(BaseOptions options) {
    var dio = Dio(options);
    dio.interceptors.add(LogInterceptor());
    return dio;
  }

  static String? convertResponseToString(Response<dynamic> response) {
    var statusCode = response.statusCode;
    if (httpCodeSuccess == statusCode) {
      var data = response.data;
      if (data is String) {
        debugPrint('response = $data');
        return data;
      }
    }
    return null;
  }
}
