import 'package:flutter/material.dart';
import 'package:mt/screen/addTicket/addTicket_screen.dart';
import 'package:mt/screen/changePassword/changePassword_screen.dart';
import 'package:mt/screen/history/history_screen.dart';
import 'package:mt/screen/history/todo_history_screen.dart';
import 'package:mt/screen/home_screen.dart';
import 'package:mt/screen/login/login_screen.dart';
import 'package:mt/screen/checkForgot/checkForgot_screen.dart';


final routes = {
  '/home':       (BuildContext context) => new HomeScreen(),
  '/login':      (BuildContext context) => new LoginScreen(),
  '/checkdata':      (BuildContext context) => new CheckForgotScreen(),
  '/change':      (BuildContext context) => new ChangePasswordScreen(),
  '/add':      (BuildContext context) => new AddTicketScreen(),
  '/history':      (BuildContext context) => new HistoryScreen(),
  '/todohistory':      (BuildContext context) => new TodoHistoryScreen(),


};