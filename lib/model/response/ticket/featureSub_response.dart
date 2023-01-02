import 'package:mt/model/modelJson/ticket/featureSub_model.dart';

class FeatureSubResponse {
  final featureSub results;
  final String error;

  FeatureSubResponse(this.results, this.error);

  FeatureSubResponse.fromJson(Map<String, dynamic> json)
      : results = new featureSub.fromJson(json),
        error = "";

  FeatureSubResponse.withError(String errorValue)
      : results = featureSub(),
        error = errorValue;
}