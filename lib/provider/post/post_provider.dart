import 'package:dio/dio.dart';
import 'package:mt/data/sharedpref/preferences.dart';
import 'package:mt/model/modelJson/post/post_model.dart';
import 'package:mt/model/response/post/post_response.dart';
import 'package:mt/provider/dio/dio_config.dart';
import 'package:mt/provider/dio/interceptor/logging_interceptor.dart';
import '../../data/api/app_api.dart';
import 'dart:developer';


class PostProvider {
  Dio _dio;

  PostProvider() {
    _dio = DioConfig().ApiServiceTime();
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<PostResponse> getPost(token) async {
    try {
      print('token_provider: '+token);
      _dio.options.headers["authorization"] = "Bearer ${token}";
      Response response = await _dio.get(urlAPI.posts,);
      return PostResponse.fromJson(response.data);
    } on DioError catch(e) {
      // return LoginResponse.withError(ErrHandler.getErrMessage(e));
      return PostResponse.withError('Check Connection / User credentials');
    }
  }

}