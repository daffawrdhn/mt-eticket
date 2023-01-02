// import 'package:mt/model/modelJson/ticket/ticketAdd_model.dart';
import 'package:mt/model/modelJson/ticket/ticketAdd_model.dart';

class TicketAddResponse {
  final ticketAdd results;
  final String error;

  TicketAddResponse(this.results, this.error);

  TicketAddResponse.fromJson(Map<String, dynamic> json)
      : results = new ticketAdd.fromJson(json),
        error = "";

  TicketAddResponse.withError(String errorValue)
      : results = ticketAdd(),
        error = errorValue;
}