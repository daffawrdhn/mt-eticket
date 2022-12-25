import 'package:dio/dio.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import '../../bloc/loading/loading_bloc.dart';
import '../../data/local/app_data.dart';
import '../../data/sharedpref/preferences.dart';
import 'package:rxdart/rxdart.dart';

import 'package:mt/model/response/forgotPassword/forgotPassword_response.dart';
import 'package:mt/provider/forgotPassword/forgotPassword_provider.dart';
import '../../bloc/forgotPassword/validators.dart';

class ForgotPasswordBloc extends Object with Validators {
  final ForgotPasswordProvider _forgotPasswordProvider = ForgotPasswordProvider();
  final BehaviorSubject<ForgotPasswordResponse> _subject =
      BehaviorSubject<ForgotPasswordResponse>();

  final _password = BehaviorSubject<String>();
  final _passwordConfirm = BehaviorSubject<String>();

  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<String> get passwordConfirm => _passwordConfirm.stream.transform(validateConfirmPassword);

  Stream<bool> get submitValid => Rx.combineLatest2(password, passwordConfirm, (a, b) => true);

  Function(String) get changePassword => _password.sink.add;
  Function(String) get changePasswordConfirm => _passwordConfirm.sink.add;

  resetBloc() {
    appData.setErrMsg("");
    _password.sink.add(null);
    _passwordConfirm.sink.add(null);
    _subject.sink.add(null);
  }

  resetResponse() {
    appData.setErrMsg('');
    _subject.sink.add(null);
  }

  Future change() async {
    loadingBloc.updateLoading(true);
    appData.setErrMsg("");

    FormData formData = new FormData.fromMap({
      "new_password": _password.value,
      "new_password_confirm": _passwordConfirm.value,
    });

    print(_password.value);
    print(_passwordConfirm.value);

    ForgotPasswordResponse response = await _forgotPasswordProvider.change(formData);

    if (response.results.success == true) {
      Prefs.clear();
      AppData().token = "";
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
    _password.close();
    _passwordConfirm.close();
    _subject.close();
  }

  BehaviorSubject<ForgotPasswordResponse> get subject => _subject;
}

final forgotPasswordBloc = ForgotPasswordBloc();
