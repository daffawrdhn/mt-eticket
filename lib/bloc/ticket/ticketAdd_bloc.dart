import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/model/response/ticket/ticketAdd_response.dart';
import 'package:mt/provider/ticket/ticketAdd_provider.dart';
import '../../bloc/loading/loading_bloc.dart';
import '../../data/local/app_data.dart';
import '../../data/sharedpref/preferences.dart';
import 'package:rxdart/rxdart.dart';

import 'package:mt/provider/changePassword/changePassword_provider.dart';
import 'package:mt/bloc/ticket/add_validators.dart';




class TicketAddBloc extends Object with ValidatorsAdd {
  final TicketAddProvider _ticketAdd = TicketAddProvider();
  final BehaviorSubject<TicketAddResponse> _subject = BehaviorSubject<TicketAddResponse>();

  final _feature = BehaviorSubject<int>();
  final _subfeature = BehaviorSubject<int>();
  final _title = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _photo = BehaviorSubject<File>();

  Stream<int> get feature => _feature.stream.transform(validateFeature);
  Stream<int> get subfeature => _subfeature.stream.transform(validateSubfeature);
  Stream<String> get title => _title.stream.transform(validateTitle);
  Stream<String> get description => _description.stream.transform(validateDescription);
  Stream<File> get photo => _photo.stream.transform(validatePhoto);

  Function(int) get changeFeature => _feature.sink.add;
  Function(int) get changeSubfeature => _subfeature.sink.add;
  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(File) get changePhoto => _photo.sink.add;

  Stream<bool> get submitValid => Rx.combineLatest4(feature, subfeature, title, description, (a, b, c, d) => true);

  resetBloc() {
    appData.setErrMsg("");
    _feature.sink.add(null);
    _subfeature.sink.add(null);
    _title.sink.add(null);
    _description.sink.add(null);
    _photo.sink.add(null);
    _subject.sink.add(null);
  }

  resetResponse() {
    appData.setErrMsg('');
    _subject.sink.add(null);
  }

  Future create() async {
    loadingBloc.updateLoading(true);
    appData.setErrMsg("");

    FormData formData = new FormData.fromMap({
      "feature_id": _feature.value,
      "sub_feature_id": _subfeature.value,
      "ticket_title": _title.value,
      "ticket_description": _description.value,
      // Add the selected photo to the form data
      "photo": _photo.value == null
          ? null
          : await MultipartFile.fromFile(_photo.value.path, filename: "image.jpg"),
    });

    // print(_photo.value.path);

    TicketAddResponse response = await _ticketAdd.post(formData);

    if (response.results.success == true) {
      _subject.sink.add(response);
    } else {
      _subject.sink.add(response);
      appData.setErrMsg(response.error);
      errorBloc.updateErrMsg(response.error);
    }
    loadingState(false);
  }

  void loadingState(bool loading) {
    loadingBloc.updateLoading(loading);
  }

  dispose() {
    _feature.close();
    _subfeature.close();
    _title.close();
    _description.close();
    _photo.close();
    _subject.close();
  }

  BehaviorSubject<TicketAddResponse> get subject => _subject;
}

final ticketAddBloc = TicketAddBloc();