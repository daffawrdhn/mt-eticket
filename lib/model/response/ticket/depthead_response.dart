import 'package:mt/model/modelJson/ticket/depthead_model.dart';
import 'package:mt/model/modelJson/ticket/featureSub_model.dart';

class DeptheadResponse {
  final depthead results;
  final String error;

  DeptheadResponse(this.results, this.error);

  DeptheadResponse.fromJson(Map<String, dynamic> json)
      : results = new depthead.fromJson(json),
        error = "";

  DeptheadResponse.withError(String errorValue)
      : results = depthead(),
        error = errorValue;
}