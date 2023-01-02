import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mt/bloc/ticket/ticketAdd_bloc.dart';
import 'package:mt/model/modelJson/ticket/featureSub_model.dart';
import 'package:mt/model/modelJson/ticket/ticketAdd_model.dart';
import 'package:mt/model/response/ticket/featureSub_response.dart';
import 'package:mt/model/response/ticket/ticketAdd_response.dart';
import 'package:mt/provider/ticket/featureSub_provider.dart';
import 'package:rxdart/rxdart.dart';

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

class AddTicketScreen extends StatefulWidget {
  @override
  _AddTicketScreenState createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  // Declare a variable to store the selected feature ID
  int _selectedFeatureId;

  // Declare a list of Feature objects to store the fetched data
  List<Feature> _features;

  // Declare a variable to store the selected sub-feature ID
  int _selectedSubFeatureId;

  // Declare a list of SubFeature objects to store the sub-features for the selected feature
  List<SubFeature> _subFeatures;

  // Declare a variable to store the FeatureSubProvider instance
  FeatureSubProvider _featureSubProvider = FeatureSubProvider();

  String androidId = '';
  bool isLogin = true;
  bool isRegister = false;
  bool isRecoverPassword = false;

  XFile image;
  File picture;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      picture = File(image.path);
      ticketAddBloc.changePhoto(picture);
    });
  }

  //show popup dialog
  void SelectImg() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void doLogin() async {
    FocusScope.of(context).requestFocus(FocusNode());
    ticketAddBloc.resetResponse();
    ticketAddBloc.create();
  }

  void popupDialogAlert(String message) {
    showAlertDialog(
      context: context,
      message: message == 'null' ? "" : message,
      icon: Icons.info_outline,
      type: 'failed',
      onOk: () {
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
        // Navigate to the '/login' route and perform an action after the route has been replaced
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      },
    );
  }

  void initState() {
    super.initState();
    Prefs.clear();
    AppData().count = 1;

    _fetchFeatureSubData().then((_) {
      setState(() {
        // Set the initial value for _selectedSubFeatureId
        _selectedSubFeatureId = _subFeatures[0].subFeatureId;
        // Set the initial value for _selectedFeatureId
        _selectedFeatureId = _features[0].featureId;
        // Update the value in ticketAddBloc
        ticketAddBloc.changeSubfeature(_selectedSubFeatureId);
        ticketAddBloc.changeFeature(_selectedFeatureId);
      });
    });
    ticketAddBloc.resetBloc();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void dispose() {
    // Dispose of any resources here
    super.dispose();
  }

  _fetchFeatureSubData() async {
    try {
      // Make the HTTP request to get the featureSub data
      FeatureSubResponse response = await _featureSubProvider.get();

      // Set the _features and _subFeatures variables with the fetched data
      setState(() {
        _features = response.results.data.feature;
        _selectedFeatureId = _features[0].featureId;
        _subFeatures = _features[0].subFeature;
        _selectedSubFeatureId = _subFeatures[0].subFeatureId;
      });
    } catch (error) {
      // Handle the error
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget submitButton() {
      return StreamBuilder(
          stream: ticketAddBloc.submitValid,
          builder: (context, snapshot) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: ElevatedButton(
                  child: Text('CREATE'),
                  style: ElevatedButton.styleFrom(
                      elevation: 15.0,
                      primary: AppColors.loginSubmit,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      textStyle:
                          Styles.customTextStyle(Colors.black, 'bold', 18.0)),
                  onPressed: snapshot.data == true ? doLogin : null,
                ));
          });
    }

    Widget _buildLoadingWidget() {
      return StreamBuilder(
          stream: loadingBloc.isLoading,
          builder: (context, snapshot) {
            if (snapshot.data == true) {
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
            } else {
              return submitButton();
            }
          });
    }

    Widget _forgotPassword() {
      return GestureDetector(
        onTap: () {
          Future.microtask(() => Navigator.pushNamed(context, '/checkdata'));
        },
        child: Text(
          'Forgot Password',
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              color: AppColors.loginSubmit),
        ),
      );
    }

    Widget _buildErrorWidget(String error) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            error,
            textAlign: TextAlign.center,
            style: Styles.customTextStyle(
                error.contains("berhasil") ? Colors.green : Colors.red,
                'bold',
                14.0),
          ),
        ],
      ));
    }

    Widget errResponse() {
      return StreamBuilder(
        initialData: null,
        stream: errorBloc.errMsg,
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data.toString().length > 1) {
            appData.count = appData.count + 1;
            if (appData.count == 2) {
              appData.count = 0;
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => popupDialogAlert(snapshot.data));
            }
            return Container();
          } else {
            return Container();
          }
        },
      );
    }

    Widget responseWidget() {
      return StreamBuilder<TicketAddResponse>(
        stream: ticketAddBloc.subject.stream,
        builder: (context, AsyncSnapshot<TicketAddResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return Container();
            } else {
              WidgetsBinding.instance.addPostFrameCallback(
                  (_) => popupDialogAlertChange(snapshot.data.results.message));
              // Future.microtask(() => Navigator.pushReplacementNamed(context, '/home'));
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
          title: Text('Create New Ticket'),
        ),
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Ticket title',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Card(
                      elevation: 0.0,
                      child: Container(
                          decoration: Decorations.containerBoxDecoration(),
                          child: StreamBuilder(
                              stream: ticketAddBloc.title,
                              builder: (context, snapshot) {
                                return TextField(
                                  onChanged: ticketAddBloc.changeTitle,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  style: Styles.customTextStyle(
                                      Colors.black, 'bold', 15.0),
                                  decoration: Decorations.textInputDecoration(
                                      StringConst.hintTitle,
                                      snapshot.error,
                                      Colors.white),
                                  maxLines: 1,
                                );
                              })),
                    ),
                    SizedBox(height: 20.0),
                    FutureBuilder(
                        future: _features == null ? _fetchFeatureSubData() : null,
                        builder: (context, snapshot) {
                          if (snapshot.hasData || _features != null) {
                            return Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: DropdownButton<int>(
                                            value: _selectedFeatureId,
                                            onChanged: (int newValue) {
                                              ticketAddBloc.changeFeature(newValue);
                                              // Set the selectedFeatureId and fetch the sub-features for the selected feature
                                              setState(() {
                                                _selectedFeatureId = newValue;
                                                _subFeatures = _features.firstWhere((feature) => feature.featureId == _selectedFeatureId).subFeature;
                                                _selectedSubFeatureId = _subFeatures[0].subFeatureId;
                                              });
                                            },
                                            items: _features.map((feature) {
                                              return DropdownMenuItem<int>(
                                                value: feature.featureId,
                                                child: Text(feature.featureName),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: DropdownButton<int>(
                                            value: _selectedSubFeatureId,
                                            onChanged: (int newValue) {
                                              ticketAddBloc.changeSubfeature(newValue);
                                              // Set the selectedSubFeatureId
                                              setState(() {
                                                _selectedSubFeatureId = newValue;
                                              });
                                            },
                                            items: _subFeatures.map((subFeature) {
                                              return DropdownMenuItem<int>(
                                                value: subFeature.subFeatureId,
                                                child: Text(subFeature.subFeatureName),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Description',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Card(
                      elevation: 0.0,
                      child: Container(
                          decoration: Decorations.containerBoxDecoration(),
                          child: StreamBuilder(
                              stream: ticketAddBloc.description,
                              builder: (context, snapshot) {
                                return TextField(
                                  maxLines: 6,
                                  onChanged: ticketAddBloc.changeDescription,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  style: Styles.customTextStyle(
                                      Colors.black, 'bold', 15.0),
                                  decoration: Decorations.textInputDecoration(
                                      StringConst.hintDescription,
                                      snapshot.error,
                                      Colors.white),
                                );
                              })),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            image == null ? ElevatedButton(
                              onPressed: () {
                                SelectImg();
                              },
                              child: Text('Upload Photo'),
                            ) : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            //if image not null show the image
                            //if image null show text
                            image != null
                                ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      //to show image, you type like this.
                                      File(image.path),
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                    ),
                                  ),
                                ),
                                // Add an ElevatedButton for removing the image
                                ElevatedButton(
                                  onPressed: () {
                                    // Remove the selected image
                                    ticketAddBloc.changePhoto(null);
                                    setState(() {
                                      image = null;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete),
                                      Text('Remove Image'),
                                    ],
                                  ),
                                ),
                              ],
                            )
                                : Text(
                              "No Image",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _buildLoadingWidget(),
                    SizedBox(height: 20.0),
                    responseWidget(),
                    SizedBox(height: 15.0),
                    SizedBox(height: 20.0),
                    errResponse(),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
