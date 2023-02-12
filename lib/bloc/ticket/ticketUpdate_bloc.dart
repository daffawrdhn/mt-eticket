import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/model/response/ticket/helpdesk_response.dart';
import 'package:mt/model/response/ticket/pic_response.dart';
import 'package:mt/model/response/ticket/ticketAdd_response.dart';
import 'package:mt/model/response/ticket/ticketUpdate_response.dart';
import 'package:mt/model/response/ticket/tickets_response.dart';
import 'package:mt/provider/ticket/ticketAdd_provider.dart';
import 'package:mt/provider/ticket/tickets_provider.dart';
import '../../bloc/loading/loading_bloc.dart';
import '../../data/local/app_data.dart';
import '../../data/sharedpref/preferences.dart';
import 'package:rxdart/rxdart.dart';

import 'package:mt/provider/changePassword/changePassword_provider.dart';
import 'package:mt/bloc/ticket/add_validators.dart';




class TicketUpdateBloc extends Object {

  final TicketsProvider _ticket = TicketsProvider();
  final BehaviorSubject<TicketUpdateResponse> _subject = BehaviorSubject<TicketUpdateResponse>();

  resetBloc() {
    appData.setErrMsg("");
    _subject.sink.add(null);
  }

  resetResponse() {
    appData.setErrMsg('');
    _subject.sink.add(null);
  }

  Future update(int approval, int id, String employeeId) async {
    loadingBloc.updateLoading(true);
    appData.setErrMsg("");

    print('EMPLOYEE: '+employeeId);

    TicketUpdateResponse response = await _ticket.updateTicket(approval, id, employeeId);

    if (response.results.success == true) {
      _subject.sink.add(response);
    } else {
      loadingBloc.updateLoading(false);
      _subject.sink.add(response);
      appData.setErrMsg(response.error);
      errorBloc.updateErrMsg(response.error);
    }
    loadingBloc.updateLoading(false);
  }

  void loadingState(bool loading) {
    loadingBloc.updateLoading(loading);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<TicketUpdateResponse> get subject => _subject;
}

final ticketUpdateBloc = TicketUpdateBloc();