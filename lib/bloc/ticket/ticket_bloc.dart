import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/loading/loading_bloc.dart';
import 'package:mt/model/response/ticket/depthead_response.dart';
import 'package:mt/model/response/ticket/helpdesk_response.dart';
import 'package:mt/model/response/ticket/pic_response.dart';
import 'package:mt/model/response/ticket/tickets_response.dart';
import 'package:mt/provider/ticket/tickets_provider.dart';

import '../../data/local/app_data.dart';
import 'package:rxdart/rxdart.dart';

class TicketBloc extends Object {


  final TicketsProvider _ticket = TicketsProvider();

  //TICKETS
  final BehaviorSubject<TicketsResponse> _subject = BehaviorSubject<TicketsResponse>();
  final BehaviorSubject<PicResponse> _subject_pic = BehaviorSubject<PicResponse>(); //PIC
  final BehaviorSubject<HelpdeskResponse> _subject_helpdesk = BehaviorSubject<HelpdeskResponse>(); //HELPDESK
  final BehaviorSubject<DeptheadResponse> _subject_depthead = BehaviorSubject<DeptheadResponse>(); //HELPDESK
  final BehaviorSubject<Uint8List> _foto = BehaviorSubject<Uint8List>(); //FOTO

  final _searchText = BehaviorSubject<String>();
  final _pic = BehaviorSubject<String>();
  final _helpdesk = BehaviorSubject<String>();
  final _depthead = BehaviorSubject<String>();
  final _approval = BehaviorSubject<bool>();

  Stream<String> get searchText => _searchText.stream;
  Stream<String> get pic => _pic.stream;
  Stream<String> get helpdesk => _helpdesk.stream;
  Stream<String> get depthead => _depthead.stream;
  Stream<bool> get approval => _approval.stream;
  Stream<Uint8List> get foto => _foto.stream;


  Function(String) get changeSearchText => _searchText.sink.add;
  Function(String) get changePic => _pic.sink.add;
  Function(String) get changeHelpdesk => _helpdesk.sink.add;
  Function(String) get changeDepthead => _depthead.sink.add;
  Function(bool) get changeApproval => _approval.sink.add;
  Function(Uint8List) get changeFoto => _foto.sink.add;

  Future<Uint8List> getFoto(ticketId) async {
    appData.setErrMsg("");
    Uint8List response = await _ticket.getFoto(ticketId);
    try {
      _foto.sink.add(response);
      return response;
    } catch (e) {
      _foto.sink.add(null);
      appData.setErrMsg(e.toString());
      errorBloc.updateErrMsg(e.toString());
    }
  }

  Future<TicketsResponse> get() async {
    appData.setErrMsg("");
    TicketsResponse response = await _ticket.getTickets();
    if (response.results.success == true) {
      _subject.sink.add(response);
      return response;
    } else {
      _subject.sink.add(response);
      appData.setErrMsg(response.error);
      errorBloc.updateErrMsg(response.error);
    }
  }

  Future<TicketsResponse> getApproval() async {
    appData.setErrMsg("");
    TicketsResponse response = await _ticket.getApproval();
    if (response.results.success == true) {
      _subject.sink.add(response);
      return response;
    } else {
      _subject.sink.add(response);
      appData.setErrMsg(response.error);
      errorBloc.updateErrMsg(response.error);
    }
  }

  Future<TicketsResponse> getHistory() async {
    appData.setErrMsg("");
    TicketsResponse response = await _ticket.history();
    if (response.results.success == true) {
      _subject.sink.add(response);
      return response;
    } else {
      _subject.sink.add(response);
      appData.setErrMsg(response.error);
      errorBloc.updateErrMsg(response.error);
    }
  }

  Future<PicResponse> getPics(regionalId) async {
    appData.setErrMsg("");
    PicResponse response = await _ticket.getPics(regionalId);
    if (response.results.success == true) {
      _subject_pic.sink.add(response);
      return response;
    } else {
      _subject_pic.sink.add(response);
      appData.setErrMsg(response.error);
      errorBloc.updateErrMsg(response.error);
    }
  }

  Future<HelpdeskResponse> getHelpdesks(regionalId) async {
    appData.setErrMsg("");
    HelpdeskResponse response = await _ticket.getHelpdesks(regionalId);
    if (response.results.success == true) {
      _subject_helpdesk.sink.add(response);
      return response;
    } else {
      _subject_helpdesk.sink.add(response);
      appData.setErrMsg(response.error);
      errorBloc.updateErrMsg(response.error);
    }
  }

  Future<DeptheadResponse> getDepthead() async {
    appData.setErrMsg("");
    DeptheadResponse response = await _ticket.getDepthead();
    if (response.results.success == true) {
      _subject_depthead.sink.add(response);
      return response;
    } else {
      _subject_depthead.sink.add(response);
      appData.setErrMsg(response.error);
      errorBloc.updateErrMsg(response.error);
    }
  }

  void loadingState(bool loading){
    loadingBloc.updateLoading(loading);
  }

  resetBloc() {
    appData.setErrMsg("");
    _subject.sink.add(null);
    // _searchText.add(null);
    _pic.sink.add(null);
    _helpdesk.sink.add(null);
    _depthead.sink.add(null);
    _approval.sink.add(null);
    _foto.sink.add(null);
  }

  resetResponse() {
    appData.setErrMsg('');
    _subject.sink.add(null);
    _searchText.add('');
  }

  dispose() {
    _subject.close();
    _pic.close();
    _searchText.close();
    _helpdesk.close();
    _depthead.close();
    _approval.close();
    _foto.close();
  }
}
final ticketBloc = TicketBloc();