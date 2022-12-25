import 'package:mt/model/modelJson/checkForgot/checkForgot_model.dart';

class CheckForgotResponse {
  final checkForgot results;
  final String error;

  CheckForgotResponse(this.results, this.error);

  CheckForgotResponse.fromJson(Map<String, dynamic> json)
      : results = new checkForgot.fromJson(json),
        error = "";

  CheckForgotResponse.withError(String errorValue)
      : results = checkForgot(),
        error = errorValue;
}