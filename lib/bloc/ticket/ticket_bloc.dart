import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/loading/loading_bloc.dart';
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


  final _searchText = BehaviorSubject<String>();
  final _pic = BehaviorSubject<String>();
  final _helpdesk = BehaviorSubject<String>();
  final _approval = BehaviorSubject<bool>();


  Stream<String> get searchText => _searchText.stream;
  Stream<String> get pic => _pic.stream;
  Stream<String> get helpdesk => _helpdesk.stream;
  Stream<bool> get approval => _approval.stream;


  Function(String) get changeSearchText => _searchText.sink.add;
  Function(String) get changePic => _pic.sink.add;
  Function(String) get changeHelpdesk => _helpdesk.sink.add;
  Function(bool) get changeApproval => _approval.sink.add;


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

  void loadingState(bool loading){
    loadingBloc.updateLoading(loading);
  }

  resetBloc() {
    appData.setErrMsg("");
    _subject.sink.add(null);
    // _searchText.add(null);
    _pic.sink.add(null);
    _helpdesk.sink.add(null);
    _approval.sink.add(null);

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
    _approval.close();
  }
}
final ticketBloc = TicketBloc();