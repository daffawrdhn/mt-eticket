
import 'package:mt/resource/values/values.dart';
import '../../data/sharedpref/preferences.dart';
import 'package:mt/model/modelJson/login/login_model.dart';
import 'package:mt/model/response/ticket/tickets_response.dart';
import 'package:mt/model/modelJson/ticket/tickets_model.dart' as ticket;


class AppData {
  static final AppData _appData = new AppData._internal();

  String baseUrlLocal = "http://10.0.2.2/api";
  String baseUrlServer = "http://203.175.11.220/api";
  String errMsg = "";
  String token = "";

  String version = '1.0.12';

  int count = 1;
  Login user;

  void setErrMsg(String error){
    if(error == null || error == ""){
      errMsg = "";
    }else{
      if(error.contains('login')){
        Prefs.clear();
      }
      errMsg = error;
    }
  }

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}
final appData = AppData();