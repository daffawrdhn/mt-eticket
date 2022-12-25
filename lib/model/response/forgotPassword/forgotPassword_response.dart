import 'package:mt/model/modelJson/forgotPassword/forgotPassword_model.dart';

class ForgotPasswordResponse {
  final forgotPassword results;
  final String error;

  ForgotPasswordResponse(this.results, this.error);

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json)
      : results = new forgotPassword.fromJson(json),
        error = "";

  ForgotPasswordResponse.withError(String errorValue)
      : results = forgotPassword(),
        error = errorValue;
}