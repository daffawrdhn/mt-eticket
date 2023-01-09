import 'dart:io';
import 'package:dio/dio.dart';
import '../../data/api/app_api.dart';
import '../../resource/values/values.dart';

class DioConfig {
  // ignore: non_constant_identifier_names
  Dio ApiServiceTime() {
    Dio dio = new Dio();
    dio.options.baseUrl = urlAPI.baseUrl;
    dio.options.connectTimeout = StringConst.connectTimeout;
    dio.options.receiveTimeout = StringConst.receiveTimeout;
    return dio;
  }

  Options dioOptionsWithToken(){
    Options options = Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'authorize_app_platform': 'mobile',
          'requirestoken': true,
          // 'Content-Type': 'application/x-www-form-urlencoded'
        },
        followRedirects: false,
        validateStatus: (status) { return status <= 200; }
    );
    return options;
  }

  Options dioOptions(){
    Options options = Options(
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'authorize_app_platform': 'mobile',
        },
        followRedirects: false,
        validateStatus: (status) { return status <= 200; }
    );
    return options;
  }

  Options dioOptionsWithTokenBytes(){
    Options options = Options(
        responseType: ResponseType.bytes,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'authorize_app_platform': 'mobile',
        'requirestoken': true,
      },
    );
    return options;
  }

  Options dioOptionsWithTokenJson(){
    Options options = Options(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'X-Requested-With': 'XMLHttpRequest',
        'authorize_app_platform': 'mobile',
        'requirestoken': true,
      },
    );
    return options;
  }
}