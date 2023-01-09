// import 'package:mt/model/modelJson/ticket/ticket_model.dart';
// import 'package:mt/model/modelJson/ticket/ticket_model.dart';
import 'package:mt/model/modelJson/ticket/ticketPhoto_model.dart';
import 'package:mt/model/modelJson/ticket/tickets_model.dart';

class TicketsPhotoResponse {
  final ticketPhoto results;
  final String error;

  TicketsPhotoResponse(this.results, this.error);

  TicketsPhotoResponse.fromJson(Map<String, dynamic> json)
      : results = new ticketPhoto.fromJson(json),
        error = "";

  TicketsPhotoResponse.withError(String errorValue)
      : results = ticketPhoto(),
        error = errorValue;
}