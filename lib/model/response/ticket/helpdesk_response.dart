import 'package:mt/model/modelJson/ticket/helpdesk_model.dart';

class HelpdeskResponse {
  final helpdesk results;
  final String error;

  HelpdeskResponse(this.results, this.error);

  HelpdeskResponse.fromJson(Map<String, dynamic> json)
      : results = new helpdesk.fromJson(json),
        error = "";

  HelpdeskResponse.withError(String errorValue)
      : results = helpdesk(),
        error = errorValue;
}