// import 'package:mt/model/modelJson/ticket/ticket_model.dart';
// import 'package:mt/model/modelJson/ticket/ticket_model.dart';
import 'package:mt/model/modelJson/ticket/tickets_model.dart';

class TicketsResponse {
  final tickets results;
  final String error;

  TicketsResponse(this.results, this.error);

  TicketsResponse.fromJson(Map<String, dynamic> json)
      : results = new tickets.fromJson(json),
        error = "";

  TicketsResponse.withError(String errorValue)
      : results = tickets(),
        error = errorValue;
}