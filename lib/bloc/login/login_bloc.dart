import 'package:dio/dio.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/provider/login/login_provider.dart';
import 'package:mt/screen/login/login_screen.dart';
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
  // final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _isLoading = BehaviorSubject<bool>();
  final _emailSosMed = BehaviorSubject<String>();
  final _provider = BehaviorSubject<String>();
  final _providerID = BehaviorSubject<String>();
  final _fcmToken = BehaviorSubject<String>();
  final _isUpdate = BehaviorSubject<bool>();

  Stream<String> get nik    => _nik.stream.transform(validateNik);
  // Stream<String> get email    => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  // Stream<String> get emailSosMed    => _emailSosMed.stream;
  // Stream<String> get provider   => _provider.stream;
  // Stream<String> get providerID  => _providerID.stream;
  // Stream<String> get fcmToken => _fcmToken.stream;
  // Stream<bool> get isLoading => _isLoading.stream;
  // Stream<bool> get isUpdate => _isUpdate.stream;
  Stream<bool> get submitValid => Rx.combineLatest2(nik, password, (e, p) => true);
  // Stream<bool> get submitValid => Rx.combineLatest2(email, password, (e, p) => true);

  Function(String) get changeNik    => _nik.sink.add;
  // Function(String) get changeEmail   => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  // Function(String) get changeEmailSosMed => _emailSosMed.sink.add;
  // Function(String) get changeProvider => _provider.sink.add;
  // Function(String) get changeProviderID => _providerID.sink.add;
  // Function(String) get updateFcmToken => _fcmToken.sink.add;
  // Function(bool) get updateLoading => _isLoading.sink.add;
  // Function(bool) get changeIsUpdate => _isUpdate.sink.add;

  resetBloc(){
    appData.setErrMsg("");
    _nik.sink.add(null);
    // _email.sink.add(null);
    _password.sink.add(null);
    _subject.sink.add(null);
    // _emailSosMed.sink.add(null);
    // _provider.sink.add(null);
    // _providerID.sink.add(null);
    // _fcmToken.sink.add(null);
    // _isUpdate.sink.add(false);
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
    // _email.close();
    _password.close();
    _subject.close();
    // _isLoading.close();
    // _emailSosMed.close();
    // _provider.close();
    // _providerID.close();
    // _fcmToken.close();
    // _isUpdate.close();
  }

  BehaviorSubject<LoginResponse> get subject => _subject;
}

final loginBloc = LoginBloc();