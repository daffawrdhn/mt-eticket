import 'package:dio/dio.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/resource/values/values.dart';
import '../../../model/response/error/error_response.dart';

class ErrHandler {
  static String getErrMessage(DioError error) {
    var errorDescription = "";
    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = StringConst.err_cancelReq;
          break;
        case DioErrorType.connectTimeout:
          errorDescription = StringConst.err_connectionTimeOut;
          break;
        case DioErrorType.other:
          errorDescription = StringConst.errConnection;
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = StringConst.err_timeout;
          break;
        case DioErrorType.response:
          if(dioError.response.statusCode == 302 || dioError.response.statusCode == 500){
            errorDescription = StringConst.err_unexpected;
          }else{
            print(dioError.response.data);
            ErrResponse errorJson = ErrResponse.fromJson(dioError.response.data);
            errorDescription = errorJson.data.error.toString();
          }
          break;
        case DioErrorType.sendTimeout:
          errorDescription = StringConst.err_timeoutSend;
          break;
      }
    } else {
      errorDescription = StringConst.err_unexpected;
    }

    return errorDescription.toString();
  }

}