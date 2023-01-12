import 'package:mt/model/modelJson/ticket/pic_model.dart';

class PicResponse {
  final pic results;
  final String error;

  PicResponse(this.results, this.error);

  PicResponse.fromJson(Map<String, dynamic> json)
      : results = new pic.fromJson(json),
        error = "";

  PicResponse.withError(String errorValue)
      : results = pic(),
        error = errorValue;
}