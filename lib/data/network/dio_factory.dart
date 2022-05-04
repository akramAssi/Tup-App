import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:test_app/app/app_prefernces.dart';
import 'package:test_app/app/constants.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "language";

class DioFactory {
  final AppPrefernces _appPrefernces;

  DioFactory(this._appPrefernces);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    int _timeout = 60 * 1000;
    String language = await _appPrefernces.getApplicationLanguage();
    Map<String, String> header = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: Constants.token,
      defaultLanguage:language
    };
    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: header,
        connectTimeout: _timeout,
        receiveTimeout: _timeout);
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          responseHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
    }
    return dio;
  }
}
