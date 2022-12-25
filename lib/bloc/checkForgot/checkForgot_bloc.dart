import 'package:dio/dio.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/screen/login/login_screen.dart';
import '../../bloc/loading/loading_bloc.dart';
import '../../data/local/app_data.dart';
import '../../data/sharedpref/preferences.dart';
import 'package:rxdart/rxdart.dart';
import 'package:device_info/device_info.dart';

import '../../model/response/login/login_response.dart';
import 'package:mt/provider/login/login_provider.dart';

import '../../model/response/checkForgot/checkForgot_response.dart';
import '../../bloc/checkForgot/validators.dart';
import 'package:mt/provider/checkForgot/checkForgot_provider.dart';


class CheckForgotBloc extends Object with Validators {
  final CheckForgotProvider _checkForgotProvider = CheckForgotProvider();
  final BehaviorSubject<CheckForgotResponse> _subject = BehaviorSubject<CheckForgotResponse>();

  final _nik = BehaviorSubject<String>();
  final _ktp = BehaviorSubject<String>();
  final _birth = BehaviorSubject<String>();

  Stream<String> get nik    => _nik.stream.transform(validateNik);
  Stream<String> get ktp => _ktp.stream.transform(validateKtp);
  Stream<String> get birth => _birth.stream.transform(validateBirth);

  // Stream<bool> get submitValid => Rx.combineLatest2(nik, password, (e, p, k) => true);
  Stream<bool> get submitValid => Rx.combineLatest3(nik, ktp, birth, (a, b, c) => true);

  Function(String) get changeNik    => _nik.sink.add;
  Function(String) get changeKtp   => _ktp.sink.add;
  Function(String) get changeBirth => _birth.sink.add;


  resetBloc(){
    appData.setErrMsg("");
    _nik.sink.add(null);
    _ktp.sink.add(null);
    _birth.sink.add(null);
    _subject.sink.add(null);
  }

  resetResponse(){
    appData.setErrMsg('');
    _subject.sink.add(null);
  }


  Future check() async {

    loadingBloc.updateLoading(true);
    appData.setErrMsg("");

    FormData formData = new FormData.fromMap({
      "employee_id": _nik.value,
      "employee_ktp": _ktp.value,
      "employee_birth": _birth.value
    });

    print(_nik.value);
    print(_ktp.value);
    print(_birth.value);

    CheckForgotResponse response = await _checkForgotProvider.check(formData);

    if(response.results.success == true){

      Prefs.setAuthToken(response.results.data.token);
      AppData().token = response.results.data.token;

      _subject.sink.add(response);
    }else{
      _subject.sink.add(response);
      appData.setErrMsg(response.error);
      errorBloc.updateErrMsg(response.error);
    }
    loadingState(false);
  }

  void loadingState(bool loading){
    loadingBloc.updateLoading(loading);
  }

  dispose() {
    _nik.close();
    _ktp.close();
    _birth.close();
    _subject.close();
  }

  BehaviorSubject<CheckForgotResponse> get subject => _subject;
}

final checkForgotBloc = CheckForgotBloc();