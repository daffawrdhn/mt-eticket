import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/loading/loading_bloc.dart';
import 'package:mt/bloc/login/login_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/data/sharedpref/preferences.dart';
import 'package:mt/helper/widget/widget_helper.dart';
import 'package:mt/model/response/login/login_response.dart';
import 'package:mt/resource/values/values.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';
import 'package:package_info/package_info.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String androidId = '';
  bool isLogin = true;
  bool isRegister = false;
  bool isRecoverPassword = false;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void doLogin() async {
    FocusScope.of(context).requestFocus(FocusNode());
    loginBloc.resetResponse();
    loginBloc.login();
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

  void initState(){
    super.initState();
    Prefs.clear();
    AppData().count = 1;
    loginBloc.resetBloc();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    Widget submitButton() {
      return StreamBuilder(
          stream: loginBloc.submitValid,
          builder: (context, snapshot) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: ElevatedButton(
                child: Text('L O G I N'),
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

    Widget _forgotPassword() {
      return GestureDetector(
        onTap: () {
          Future.microtask(() => Navigator.pushNamed(context, '/checkdata'));
        },
        child: Text('Forgot Password',
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
      int count = 0;
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
      return StreamBuilder<LoginResponse>(
        stream: loginBloc.subject.stream,
        builder: (context, AsyncSnapshot<LoginResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return Container();
            }else{
              Future.microtask(() => Navigator.pushReplacementNamed(context, '/home'));
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
                  Text("LOGIN",
                    style: Styles.customTextStyle(AppColors.loginSubmit, 'bold', 25.0)
                  ),
                  SizedBox(height: 20.0),
                  Card(
                    elevation: 0.0,
                    child: Container(
                        decoration: Decorations.containerBoxDecoration(),
                        child: StreamBuilder(
                            stream: loginBloc.nik,
                            builder: (context, snapshot) {
                              return TextField(
                                maxLength: 9,
                                onChanged: loginBloc.changeNik,
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
                  SizedBox(height: 20.0),
                  Card(
                    elevation: 0.0,
                    child: Container(
                        decoration: Decorations.containerBoxDecoration(),
                      child: StreamBuilder(
                          stream: loginBloc.password,
                          builder: (context, snapshot) {
                            return TextField(
                              maxLength: 12,
                              onChanged: loginBloc.changePassword,
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
                  _buildLoadingWidget(),
                  SizedBox(height: 20.0),
                  _forgotPassword(),
                  responseWidget(),
                  SizedBox(height: 15.0),
                  SizedBox(height: 20.0),
                  errResponse(),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}