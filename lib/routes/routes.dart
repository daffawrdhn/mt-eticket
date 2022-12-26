import 'package:flutter/material.dart';
import 'package:mt/screen/changePassword/changePassword_screen.dart';
import 'package:mt/screen/home_screen.dart';
import 'package:mt/screen/login/login_screen.dart';
import 'package:mt/screen/checkForgot/checkForgot_screen.dart';


final routes = {
  '/home':       (BuildContext context) => new HomeScreen(),
  '/login':      (BuildContext context) => new LoginScreen(),
  '/checkdata':      (BuildContext context) => new CheckForgotScreen(),
  '/change':      (BuildContext context) => new ChangePasswordScreen(),
};