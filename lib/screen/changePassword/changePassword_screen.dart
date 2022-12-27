import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/home/logout_bloc.dart';
import 'package:mt/bloc/loading/loading_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/data/sharedpref/preferences.dart';
import 'package:mt/helper/widget/widget_helper.dart';
import 'package:mt/model/response/changePassword/changePassword_response.dart';
import 'package:mt/model/response/login/login_response.dart';
import 'package:mt/resource/values/values.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';

// import 'package:mt/bloc/login/login_bloc.dart';
import 'package:mt/bloc/changePassword/changePassword_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  String androidId = '';
  bool isLogin = false;
  bool isRegister = false;
  bool isRecoverPassword = false;
  bool _obscureText = true;
  bool _obscureText2 = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;

    });
  }

  void doLogin() async {
    FocusScope.of(context).requestFocus(FocusNode());
    changePasswordBloc.resetResponse();
    changePasswordBloc.change();
  }

  void popupDialogAlert(String message){
    showAlertDialog(
      context: context,
      message: message == 'null' ? "" : message,
      icon: Icons.info_outline,
      type: 'failed',
      onOk: (){
        Navigator.pop(context);
        errorBloc.resetBloc();
      },
    );
  }

  void popupDialogAlertChange(String message) {
    showAlertDialog(
      context: context,
      message: message == 'null' ? "" : message,
      icon: Icons.done,
      type: 'success',
      onOk: () {
        // Close the dialog
        Navigator.of(context).pop();
        errorBloc.resetBloc();
        logoutBloc.logout();
        // Navigate to the '/login' route and perform an action after the route has been replaced
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      },
    );
  }

  void initState(){
    super.initState();
    Prefs.clear();
    AppData().count = 1;
    changePasswordBloc.resetBloc();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    Widget submitButton() {
      return StreamBuilder(
          stream: changePasswordBloc.submitValid,
          builder: (context, snapshot) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: ElevatedButton(
                  child: Text('CHANGE PASSWORD'),
                  style: ElevatedButton.styleFrom(
                      elevation: 15.0,
                      primary: AppColors.loginSubmit,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      textStyle: Styles.customTextStyle(Colors.black, 'bold', 18.0)),
                  onPressed: snapshot.data == true ? doLogin : null,
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

    Widget _changePassword() {
      return GestureDetector(
        onTap: () {
          Future.microtask(() => Navigator.pushReplacementNamed(context, '/checkdata'));
        },
        child: Text('Change Password',
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

    Widget errResponse(){
      return StreamBuilder(
        initialData: null,
        stream: errorBloc.errMsg,
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data.toString().length > 1) {
            appData.count = appData.count + 1;
            if(appData.count == 2){
              appData.count = 0;
              WidgetsBinding.instance.addPostFrameCallback((_) => popupDialogAlert(snapshot.data));
            }
            return Container();
          } else {
            return Container();
          }
        },
      );
    }

    Widget responseWidget(){
      return StreamBuilder<ChangePasswordResponse>(
        stream: changePasswordBloc.subject.stream,
        builder: (context, AsyncSnapshot<ChangePasswordResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return Container();
            }else{
              WidgetsBinding.instance.addPostFrameCallback((_) => popupDialogAlertChange(snapshot.data.results.message));
              // Future.microtask(() => Navigator.pushReplacementNamed(context, '/login'));
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

    Widget _backToLogin() {
      return GestureDetector(
        onTap: () async {
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

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
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
          body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0,0,20.0,0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 45.0),
                      // Image(
                      //   image: AssetImage(ImagePath.logo_h),
                      //   height: 150,
                      // ),
                      // SizedBox(height: 20.0),
                      // Text("Change Password",
                      //   style: Styles.customTextStyle(AppColors.loginSubmit, 'bold', 25.0)
                      // ),
                      SizedBox(height: 15.0),
                      Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(text: 'New Password', style: TextStyle(fontFamily: 'Mitr',fontSize: 12, color: Colors.black)),
                              TextSpan(text: '*', style: TextStyle(fontFamily: 'Mitr',fontSize: 12, color: Colors.red)),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0.0,
                        child: Container(
                            decoration: Decorations.containerBoxDecoration(),
                            child: StreamBuilder(
                                stream: changePasswordBloc.password,
                                builder: (context, snapshot) {
                                  return TextField(
                                    maxLength: 12,
                                    onChanged: changePasswordBloc.changePassword,
                                    obscureText: _obscureText,
                                    style: Styles.customTextStyle(Colors.black, 'bold', 15.0),
                                    inputFormatters: <TextInputFormatter>[
                                      // for below version 2 use this
                                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9"|/?~`!@#$%^&*().,;:<>_+={}-]')),
                                    ],
                                    decoration: InputDecoration(
                                      counterText: '',
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: WidgetHelper().outlineInputBorderTextFieldRounded(),
                                      enabledBorder:  WidgetHelper().outlineInputBorderTextFieldRoundedEnabled(),
                                      errorText: snapshot.error,
                                      hintText: StringConst.hintPassword,
                                      hintStyle: Styles.customTextStyle(Colors.grey, 'bold', 15.0),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _toggle();
                                        },
                                        child: Icon(
                                            _obscureText ? Icons.visibility_off : Icons.visibility,
                                            color: _obscureText ? Colors.grey : Colors.blueGrey
                                        ),
                                      ),
                                    ),
                                    maxLines: 1,
                                  );
                                }
                            )
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(text: 'New Password Confirm', style: TextStyle(fontFamily: 'Mitr',fontSize: 12, color: Colors.black)),
                              TextSpan(text: '*', style: TextStyle(fontFamily: 'Mitr',fontSize: 12, color: Colors.red)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Card(
                        elevation: 0.0,
                        child: Container(
                            decoration: Decorations.containerBoxDecoration(),
                            child: StreamBuilder(
                                stream: changePasswordBloc.passwordConfirm,
                                builder: (context, snapshot) {
                                  return TextField(
                                    maxLength: 12,
                                    onChanged: changePasswordBloc.changePasswordConfirm,
                                    obscureText: _obscureText2,
                                    style: Styles.customTextStyle(Colors.black, 'bold', 15.0),
                                    inputFormatters: <TextInputFormatter>[
                                      // for below version 2 use this
                                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9"|/?~`!@#$%^&*().,;:<>_+={}\\-]')),
                                    ],
                                    decoration: InputDecoration(
                                      counterText: '',
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: WidgetHelper().outlineInputBorderTextFieldRounded(),
                                      enabledBorder:  WidgetHelper().outlineInputBorderTextFieldRoundedEnabled(),
                                      errorText: snapshot.error,
                                      hintText: StringConst.hintPassword,
                                      hintStyle: Styles.customTextStyle(Colors.grey, 'bold', 15.0),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _toggle2();
                                        },
                                        child: Icon(
                                            _obscureText2 ? Icons.visibility_off : Icons.visibility,
                                            color: _obscureText2 ? Colors.grey : Colors.blueGrey
                                        ),
                                      ),
                                    ),
                                    maxLines: 1,
                                  );
                                }
                            )
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Password must meet the following requirements:", style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.red,
                          ),),
                          Text("- Password length must be 8-12 Character", style: TextStyle(
                            fontSize: 13,
                            color: AppColors.red,
                          ),),
                          Text("- At least one Lower Case", style: TextStyle(
                            fontSize: 13,
                            color: AppColors.red,
                          ),),
                          Text("- At least one Upper Case:", style: TextStyle(
                            fontSize: 13,
                            color: AppColors.red,
                          ),),
                          Text("- At least contain One number", style: TextStyle(
                            fontSize: 13,
                            color: AppColors.red,
                          ),),
                          Text("- At least contain one Special Character (Exclude: , \\ [ ] ' )", style: TextStyle(
                            fontSize: 13,
                            color: AppColors.red,
                          ),),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      _buildLoadingWidget(),
                      SizedBox(height: 20.0),
                      // _backToLogin(),
                      responseWidget(),
                      SizedBox(height: 15.0),
                      SizedBox(height: 20.0),
                      errResponse(),
                    ],
                  )
              ),
            ),
          )
      ),
    );
  }
}