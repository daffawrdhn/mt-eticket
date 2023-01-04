import 'package:dio/dio.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/data/sharedpref/preferences.dart';
import 'package:mt/model/response/ticket/ticketAdd_response.dart';
import 'package:mt/model/response/ticket/tickets_response.dart';
import 'package:mt/provider/dio/dio_config.dart';
import 'package:mt/provider/dio/error/err_handler.dart';
import 'package:mt/provider/dio/interceptor/logging_interceptor.dart';
import '../../data/api/app_api.dart';


class TicketsProvider {
  Dio _dio;


  TicketsProvider() {
    _dio = DioConfig().ApiServiceTime();
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<TicketsResponse> getTickets() async {
    try {
      print(Prefs.authToken.toString());
      _dio.options.headers["Authorization"] = "Bearer ${AppData().token}";
      Response response = await _dio.get(urlAPI.gettickets);
      return TicketsResponse.fromJson(response.data);
    } on DioError catch(e) {
      // print(e);
      return TicketsResponse.withError(ErrHandler.getErrMessage(e));
      // return LoginResponse.withError('Check Connection / User credentials');
    }
  }

  Future<TicketsResponse> getApproval() async {
    try {
      print(Prefs.authToken.toString());
      _dio.options.headers["Authorization"] = "Bearer ${AppData().token}";
      Response response = await _dio.get(urlAPI.getapproval);
      return TicketsResponse.fromJson(response.data);
    } on DioError catch(e) {
      // print(e);
      return TicketsResponse.withError(ErrHandler.getErrMessage(e));
      // return LoginResponse.withError('Check Connection / User credentials');
    }
  }

}