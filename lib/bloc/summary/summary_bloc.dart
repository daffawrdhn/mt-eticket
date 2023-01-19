import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/loading/loading_bloc.dart';
import 'package:mt/model/response/ticket/helpdesk_response.dart';
import 'package:mt/model/response/ticket/pic_response.dart';
import 'package:mt/model/response/ticket/tickets_response.dart';
import 'package:mt/model/summary/summary_response.dart';
import 'package:mt/provider/summary/summary_provider.dart';
import 'package:mt/provider/ticket/tickets_provider.dart';

import '../../data/local/app_data.dart';
import 'package:rxdart/rxdart.dart';

class SummaryBloc extends Object {


  final SummaryProvider _summary = SummaryProvider();

  //TICKETS
  final BehaviorSubject<SummaryResponse> _subject = BehaviorSubject<SummaryResponse>();


  Future<SummaryResponse> get() async {
    appData.setErrMsg("");
    SummaryResponse response = await _summary.get();
    if (response.results.success == true) {
      _subject.sink.add(response);
      return response;
    } else {
      _subject.sink.add(response);
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

  }

  resetResponse() {
    appData.setErrMsg('');
    _subject.sink.add(null);
  }

  dispose() {
    _subject.close();
  }
}
final summaryBloc = SummaryBloc();