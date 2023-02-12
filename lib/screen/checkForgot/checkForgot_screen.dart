import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/loading/loading_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/data/sharedpref/preferences.dart';
import 'package:mt/helper/widget/widget_helper.dart';
import 'package:mt/model/modelJson/checkForgot/checkForgot_model.dart';
import 'package:mt/resource/values/values.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';

import 'package:mt/bloc/checkForgot/checkForgot_bloc.dart';
import 'package:mt/model/response/checkForgot/checkForgot_response.dart';
import 'package:mt/widget/reuseable/dialog/dialog_error.dart';


class CheckForgotScreen extends StatefulWidget {

  @override
  _CheckForgotScreenState createState() => _CheckForgotScreenState();
}

class _CheckForgotScreenState extends State<CheckForgotScreen> {

  final dateInput = TextEditingController();

  String androidId = '';
  bool isLogin = false;
  bool isRegister = false;
  bool isRecoverPassword = true;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void doCheck() async {
    FocusScope.of(context).requestFocus(FocusNode());
    // loginBloc.resetResponse();
    checkForgotBloc.resetResponse();
    // loginBloc.login();
    checkForgotBloc.check();
  }

  void initState(){
    super.initState();
    Prefs.clear();
    // loginBloc.resetBloc();
    AppData().count = 1;
    checkForgotBloc.resetBloc();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    Widget submitButton() {
      return StreamBuilder(
          // stream: loginBloc.submitValid,
          stream: checkForgotBloc.submitValid,
          builder: (context, snapshot) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: ElevatedButton(
                  child: Text('FORGOT PASSWORD'),
                  style: ElevatedButton.styleFrom(
                      elevation: 15.0,
                      primary: AppColors.loginSubmit,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      textStyle: Styles.customTextStyle(Colors.black, 'bold', 18.0)),
                  onPressed: snapshot.data == true ? doCheck : null,
                )
            );
          }
      );
    }

    Widget _buildLoadingWidget() {
      return StreamBuilder(
          stream: loadingBloc.isLoading,
          builder: (context, snapshot) {
            if(snapshot.data == true){
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                      SizedBox(height: 10),
                      Text(StringConst.loading,
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ));
            }else{
              return submitButton();
            }
          }
      );
    }

    Widget _backToLogin() {
      return GestureDetector(
        onTap: () {
          AppData().token = "";
          Prefs.clear();
          Future.microtask(() => Navigator.pushReplacementNamed(context, '/login'));
        },
        child: Text('Back to Login',
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              color: AppColors.loginSubmit
          ),
        ),
      );
    }

    Widget _buildErrorWidget(String error) {
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(error,
                textAlign: TextAlign.center,
                style: Styles.customTextStyle(error.contains("berhasil") ? Colors.green : Colors.red, 'bold', 14.0),
              ),
            ],
          ));
    }

    Widget responseWidget(){
      return StreamBuilder<CheckForgotResponse>(
        stream: checkForgotBloc.subject.stream,
        builder: (context, AsyncSnapshot<CheckForgotResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return Container();
            }else{
              Future.microtask(() => Navigator.pushReplacementNamed(context, '/change'));
              return _buildErrorWidget("");
            }
          } else if (appData.errMsg.length > 0) {
            return Container();
          } else {
            return Container();
          }
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.loginSubmit,
          title: Text('Change Password'),
        ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('1.0.0', style: Styles.customTextStyle(Colors.black, 'bold', 15.0),textAlign: TextAlign.center,),
        ),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(20.0,0,20.0,0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 60.0),
                  Image(
                    image: AssetImage(ImagePath.logo_h),
                    height: 150,
                  ),
                  SizedBox(height: 20.0),
                  Text("CHECK DATA",
                      style: Styles.customTextStyle(AppColors.loginSubmit, 'bold', 25.0)
                  ),
                  SizedBox(height: 20.0),
                  Card(
                    elevation: 0.0,
                    child: Container(
                        decoration: Decorations.containerBoxDecoration(),
                        child: StreamBuilder(
                            stream: checkForgotBloc.nik,
                            builder: (context, snapshot) {
                              return TextField(
                                maxLength: 9,
                                onChanged: checkForgotBloc.changeNik,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                style: Styles.customTextStyle(Colors.black, 'bold', 15.0),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: Decorations.textInputDecoration(StringConst.hintNik, snapshot.error, Colors.white),
                                maxLines: 1,
                              );
                            }
                        )
                    ),
                  ),
                  Card(
                    elevation: 0.0,
                    child: Container(
                        decoration: Decorations.containerBoxDecoration(),
                        child: StreamBuilder(
                            stream: checkForgotBloc.ktp,
                            builder: (context, snapshot) {
                              return TextField(
                                maxLength: 16,
                                onChanged: checkForgotBloc.changeKtp,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                style: Styles.customTextStyle(Colors.black, 'bold', 15.0),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: Decorations.textInputDecoration(StringConst.hintKtp, snapshot.error, Colors.white),
                                maxLines: 1,
                              );
                            }
                        )
                    ),
                  ),
                  Card(
                    elevation: 0.0,
                    child: Container(
                      decoration: Decorations.containerBoxDecoration(),
                      child: StreamBuilder(
                          stream: checkForgotBloc.birth,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: dateInput,  // use the same controller as the original code
                              maxLength: 11,
                              // readOnly: true,  // set it to true so that the user cannot edit the text
                              onChanged: checkForgotBloc.changeBirth,  // use the same onChanged function as the original code
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              style: Styles.customTextStyle(Colors.black, 'bold', 15.0),
                              readOnly: true,
                              decoration: Decorations.textInputDecorationDate(StringConst.hintBirth, snapshot.error, Colors.white),
                              maxLines: 1,
                              onTap: () async {

                                String formattedDate;// add the onTap function from the original code
                                DateTime pickedDate = await DatePicker.showDatePicker(
                                  context,
                                  currentTime: DateTime.now(),
                                  minTime: DateTime(1950),
                                  maxTime: DateTime.now(),

                                );

                                if (pickedDate != null) {
                                  formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  setState(() {
                                    dateInput.text = formattedDate;  // update the TextField value with the selected date
                                  });
                                  checkForgotBloc.changeBirth(formattedDate);
                                } else {}
                              },
                            );
                          }
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _buildLoadingWidget(),
                  SizedBox(height: 20.0),
                  // _backToLogin(),
                  responseWidget(),
                  SizedBox(height: 15.0),
                  SizedBox(height: 20.0),
                  eResponse(),
                ],
              )
          ),
        ),
      ),
    ),
    );
  }
}