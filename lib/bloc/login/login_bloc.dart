import 'package:dio/dio.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/provider/login/login_provider.dart';
import '../../bloc/loading/loading_bloc.dart';
import '../../bloc/login/validators.dart';
import '../../data/local/app_data.dart';
import '../../data/sharedpref/preferences.dart';
import '../../model/response/login/login_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:device_info/device_info.dart';

class LoginBloc extends Object with Validators {
  final LoginProvider _loginProvider = LoginProvider();
  final BehaviorSubject<LoginResponse> _subject = BehaviorSubject<LoginResponse>();

  final _nik = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Stream<String> get nik    => _nik.stream.transform(validateNik);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid => Rx.combineLatest2(nik, password, (e, p) => true);

  Function(String) get changeNik    => _nik.sink.add;
  Function(String) get changePassword => _password.sink.add;

  resetBloc(){
    appData.setErrMsg("");
    _nik.sink.add(null);
    _password.sink.add(null);
    _subject.sink.add(null);
  }

  resetResponse(){
    appData.setErrMsg('');
    _subject.sink.add(null);
  }


  Future login() async {

    loadingBloc.updateLoading(true);
    appData.setErrMsg("");

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // print('Running on ${androidInfo.androidId}');

    FormData formData = new FormData.fromMap({
      "employee_id": _nik.value,
      "password": _password.value,
      "device_id": androidInfo.androidId
    });

    LoginResponse response = await _loginProvider.getLogin(formData);
    appData.user = response.results;
    if(response.results.success == true){
      Prefs.setAuthToken(response.results.token);
      Prefs.setIsLogin(true);
      AppData().token = response.results.token;
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
    _password.close();
    _subject.close();
  }

  BehaviorSubject<LoginResponse> get subject => _subject;
}

final loginBloc = LoginBloc();