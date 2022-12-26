import 'package:mt/model/modelJson/changePassword/changePassword_model.dart';

class ChangePasswordResponse {
  final changePassword results;
  final String error;

  ChangePasswordResponse(this.results, this.error);

  ChangePasswordResponse.fromJson(Map<String, dynamic> json)
      : results = new changePassword.fromJson(json),
        error = "";

  ChangePasswordResponse.withError(String errorValue)
      : results = changePassword(),
        error = errorValue;
}