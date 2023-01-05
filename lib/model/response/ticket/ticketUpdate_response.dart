
import 'package:mt/model/modelJson/ticket/ticketUpdate_model.dart';

class TicketUpdateResponse {
  final ticketUpdate results;
  final String error;

  TicketUpdateResponse(this.results, this.error);

  TicketUpdateResponse.fromJson(Map<String, dynamic> json)
      : results = new ticketUpdate.fromJson(json),
        error = "";

  TicketUpdateResponse.withError(String errorValue)
      : results = ticketUpdate(),
        error = errorValue;
}