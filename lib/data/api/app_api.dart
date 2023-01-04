import '../../data/local/app_data.dart';

// ignore: camel_case_types
class urlAPI {
  const urlAPI();
  // static String baseUrl = appData.baseUrlLocal;  //local
  static String baseUrl = appData.baseUrlLocal; //server
  static const String auth = "/login";
  static const String check = "/check-data";
  static const String change = "/forgot-password";
  static const String featuresub = "/get-features";
  static const String addticket = "/add-ticket";
  static const String gettickets = "/get-ticket";
  static const String getapproval = "/get-approval";


  static const String posts = "/blogs";
}
