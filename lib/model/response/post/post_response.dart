import 'package:mt/model/modelJson/post/post_model.dart';

class PostResponse {
  final Post results;
  final String error;

  PostResponse(this.results, this.error);

  PostResponse.fromJson(Map<String, dynamic> json)
      : results = new Post.fromJson(json),
        error = "";

  PostResponse.withError(String errorValue)
      : results = Post(),
        error = errorValue;
}