import 'dart:async';
import '../../data/sharedpref/preferences_base.dart';

class Prefs {

  static Future<String> get authToken => PreferencesHelper.getString(Const.auth_Token);

  static Future setAuthToken(String value) => PreferencesHelper.setString(Const.auth_Token, value);

  static Future<bool> get isLogin => PreferencesHelper.getBool(Const.isLogin);

  static Future setIsLogin(bool value) => PreferencesHelper.setBool(Const.isLogin, value);

  static Future setLoginID(String value) => PreferencesHelper.setString(Const.loginID, value);

  static Future<int> get userId => PreferencesHelper.getInt(Const.userId);

  static Future setUserId(int value) => PreferencesHelper.setInt(Const.userId, value);

  static Future<void> clear() async {
    await PreferencesHelper.clearPref();
  }
}

class Const {
  static const String auth_Token = 'auth_token';
  static const String isLogin = 'is_login';
  static const String loginID = "loginid";
  static const String userId = "userId";
}