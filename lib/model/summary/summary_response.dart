import 'package:mt/model/modelJson/summary/summary_model.dart';

class SummaryResponse {
  final summary results;
  final String error;

  SummaryResponse(this.results, this.error);

  SummaryResponse.fromJson(Map<String, dynamic> json)
      : results = new summary.fromJson(json),
        error = "";

  SummaryResponse.withError(String errorValue)
      : results = summary(),
        error = errorValue;
}