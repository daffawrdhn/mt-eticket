import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/response/post/post_response.dart';
import 'package:mt/provider/post/post_provider.dart';
import 'package:rxdart/rxdart.dart';

//bloc
import '../../bloc/loading/loading_bloc.dart';

//Sharedpreference
import '../../data/sharedpref/preferences.dart';



class PostBloc extends Object {
  final PostProvider _postProvider = PostProvider();
  final BehaviorSubject<PostResponse> _subject = BehaviorSubject<PostResponse>();

 Future get() async {
   loadingBloc.updateLoading(true);
   appData.setErrMsg("");

   final token = await Prefs.authToken;
   print("token: "+token);

   PostResponse response = await _postProvider.getPost(token);
   if(response.results.success == true){
     _subject.sink.add(response);
   } else {
     _subject.sink.add(response);
     appData.setErrMsg(response.error);
     errorBloc.updateErrMsg(response.error);
   }
   loadingState(false);
 }

  void loadingState(bool loading){
    loadingBloc.updateLoading(loading);
  }

  dispose() {
   _subject.close();
  }

  BehaviorSubject<PostResponse> get subject => _subject;
}
final postBloc = PostBloc();