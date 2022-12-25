import 'package:dio/dio.dart';
import 'package:mt/model/response/login/login_response.dart';
import 'package:mt/provider/dio/dio_config.dart';
import 'package:mt/provider/dio/error/err_handler.dart';
import 'package:mt/provider/dio/interceptor/logging_interceptor.dart';
import '../../data/api/app_api.dart';


class LoginProvider {
  Dio _dio;

  LoginProvider() {
    _dio = DioConfig().ApiServiceTime();
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<LoginResponse> getLogin(FormData form) async {
    try {
      Response response = await _dio.post(urlAPI.auth, data: form);
      return LoginResponse.fromJson(response.data);
    } on DioError catch(e) {
      // print(e);
      return LoginResponse.withError(ErrHandler.getErrMessage(e));
      // return LoginResponse.withError('Check Connection / User credentials');
    }
  }
}