import 'package:mt/model/modelJson/login/login_model.dart';

class LoginResponse {
  final Login results;
  final String error;

  LoginResponse(this.results, this.error);

  LoginResponse.fromJson(Map<String, dynamic> json)
      : results = new Login.fromJson(json),
        error = "";

  LoginResponse.withError(String errorValue)
      : results = Login(),
        error = errorValue;
}