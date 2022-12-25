import 'package:dio/dio.dart';
import 'package:mt/provider/dio/dio_config.dart';
import 'package:mt/provider/dio/error/err_handler.dart';
import 'package:mt/provider/dio/interceptor/logging_interceptor.dart';
import '../../data/api/app_api.dart';

import 'package:mt/model/response/checkForgot/checkForgot_response.dart';


class CheckForgotProvider {
  Dio _dio;

  CheckForgotProvider() {
    _dio = DioConfig().ApiServiceTime();
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<CheckForgotResponse> check(FormData form) async {
    try {
      Response response = await _dio.post(urlAPI.check, data: form);
      return CheckForgotResponse.fromJson(response.data);
    } on DioError catch(e) {
      print(e);
      return CheckForgotResponse.withError(ErrHandler.getErrMessage(e));
      // return LoginResponse.withError('Check Connection / User credentials');
    }
  }
}