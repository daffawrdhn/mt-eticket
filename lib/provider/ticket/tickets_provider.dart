import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/data/sharedpref/preferences.dart';
import 'package:mt/model/response/ticket/helpdesk_response.dart';
import 'package:mt/model/response/ticket/pic_response.dart';
import 'package:mt/model/response/ticket/ticketAdd_response.dart';
import 'package:mt/model/response/ticket/ticketPhoto_response.dart';
import 'package:mt/model/response/ticket/ticketUpdate_response.dart';
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

  Future<PicResponse> getPics(regionalId) async {
    try {
      print(Prefs.authToken.toString());
      _dio.options.headers["Authorization"] = "Bearer ${AppData().token}";
      Response response = await _dio.get(urlAPI.getpics+regionalId.toString());
      return PicResponse.fromJson(response.data);
    } on DioError catch(e) {
      return PicResponse.withError(ErrHandler.getErrMessage(e));
    }
  }

  Future<HelpdeskResponse> getHelpdesks() async {
    try {
      print(Prefs.authToken.toString());
      _dio.options.headers["Authorization"] = "Bearer ${AppData().token}";
      Response response = await _dio.get(urlAPI.gethelpdesk);
      return HelpdeskResponse.fromJson(response.data);
    } on DioError catch(e) {
      return HelpdeskResponse.withError(ErrHandler.getErrMessage(e));
    }
  }
  
  Future<Uint8List> getPhoto(int ticketId) async {
    try {
      Response response = await _dio.get(urlAPI.getphoto + ticketId.toString(),
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'Authorization': 'Bearer ${AppData().token}',
          },
        ),
      );
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<TicketsResponse> getTickets() async {
    try {
      print(Prefs.authToken.toString());
      _dio.options.headers["Authorization"] = "Bearer ${AppData().token}";
      Response response = await _dio.get(urlAPI.gettickets);
      return TicketsResponse.fromJson(response.data);
    } on DioError catch(e) {
      return TicketsResponse.withError(ErrHandler.getErrMessage(e));
    }
  }

  Future<TicketsResponse> getApproval() async {
    try {
      print(Prefs.authToken.toString());
      _dio.options.headers["Authorization"] = "Bearer ${AppData().token}";
      Response response = await _dio.get(urlAPI.getapproval);
      return TicketsResponse.fromJson(response.data);
    } on DioError catch(e) {
      return TicketsResponse.withError(ErrHandler.getErrMessage(e));
    }
  }

  Future<TicketUpdateResponse> updateTicket(int approval, int id, String employeeId) async {
    try {
      print(Prefs.authToken.toString());
      _dio.options.headers["Authorization"] = "Bearer ${AppData().token}";
      switch (approval) {
        case 1: //approve 1
          Response response = await _dio.patch(urlAPI.updateticketstatus+id.toString()+'?ticket_status_id=2&id='+employeeId);
          return TicketUpdateResponse.fromJson(response.data);
        case 2: //approve 2
          Response response = await _dio.patch(urlAPI.updateticketstatus+id.toString()+'?ticket_status_id=3&id='+employeeId);
          return TicketUpdateResponse.fromJson(response.data);
        case 3: //approve 3
          Response response = await _dio.patch(urlAPI.updateticketstatus+id.toString()+'?ticket_status_id=4&id='+employeeId);
          return TicketUpdateResponse.fromJson(response.data);
        case 4: //completed
          Response response = await _dio.patch(urlAPI.updateticketstatus + id.toString() + '?ticket_status_id=5&id='+employeeId);
          return TicketUpdateResponse.fromJson(response.data);
        case 5: //reject
          Response response = await _dio.patch(urlAPI.updateticketstatus + id.toString() + '?ticket_status_id=6&id='+employeeId);
          return TicketUpdateResponse.fromJson(response.data);
        default:
          return TicketUpdateResponse.withError('Invalid approval value');
      }
    } on DioError catch(e) {
      return TicketUpdateResponse.withError(ErrHandler.getErrMessage(e));
    }
  }

}