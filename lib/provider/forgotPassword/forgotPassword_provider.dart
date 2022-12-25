import 'package:dio/dio.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/data/sharedpref/preferences.dart';
import 'package:mt/model/modelJson/forgotPassword/forgotPassword_model.dart';
import 'package:mt/provider/dio/dio_config.dart';
import 'package:mt/provider/dio/error/err_handler.dart';
import 'package:mt/provider/dio/interceptor/logging_interceptor.dart';
import '../../data/api/app_api.dart';

import 'package:mt/model/response/checkForgot/checkForgot_response.dart';
import 'package:mt/model/response/forgotPassword/forgotPassword_response.dart';


class ForgotPasswordProvider {
  Dio _dio;


  ForgotPasswordProvider() {
    _dio = DioConfig().ApiServiceTime();
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<ForgotPasswordResponse> change(FormData form) async {
    try {
      print(Prefs.authToken.toString());
      _dio.options.headers["Authorization"] = "Bearer ${AppData().token}";
      Response response = await _dio.post(urlAPI.change, data: form);
      return ForgotPasswordResponse.fromJson(response.data);
    } on DioError catch(e) {
      // print(e);
      return ForgotPasswordResponse.withError(ErrHandler.getErrMessage(e));
      // return LoginResponse.withError('Check Connection / User credentials');
    }
  }
}