import '../../data/local/app_data.dart';

// ignore: camel_case_types
class urlAPI {
  const urlAPI();

  //server url
  static String baseUrl = appData.baseUrlServer;  //server
  // static String baseUrl = appData.baseUrlLocal; //local

  //auth
  static const String auth = "/login";
  static const String check = "/check-data";
  static const String change = "/forgot-password";

  //feature
  static const String featuresub = "/get-features";

  //ticket
  static const String addticket = "/add-ticket";
  static const String gettickets = "/get-ticket";
  static const String getapproval = "/get-approval";
  static const String updateticketstatus = "/update-ticket/status/";


  static const String posts = "/blogs";
}
