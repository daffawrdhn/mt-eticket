import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mt/bloc/ticket/ticketAdd_bloc.dart';
import 'package:mt/model/modelJson/ticket/featureSub_model.dart';
import 'package:mt/model/response/ticket/featureSub_response.dart';
import 'package:mt/model/response/ticket/ticketAdd_response.dart';
import 'package:mt/provider/ticket/featureSub_provider.dart';

import 'package:flutter/services.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/loading/loading_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/data/sharedpref/preferences.dart';
import 'package:mt/resource/values/values.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';
import 'package:mt/widget/reuseable/dialog/dialog_error.dart';

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
    var img = await picker.pickImage(
        source: media,
        imageQuality: 25);

    setState(() {
      image = img;
      if (image != null) {
        picture = File(image.path);
        ticketAddBloc.changePhoto(picture);
      } else {}
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
              height: MediaQuery.of(context).size.height / 12,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.loginSubmit,
                    ),
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

      // Filter out the features that don't have any sub-features
      final filteredFeatures = response.results.data.feature
          .where((feature) => feature.subFeature.isNotEmpty)
          .toList();

      // Set the _features and _subFeatures variables with the fetched data
      setState(() {
        _features = filteredFeatures;
        _selectedFeatureId = 0;
        _subFeatures = [];
        _selectedSubFeatureId = 0;
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
                  height: 60.0,
                  child: ElevatedButton(
                    child: Text('CREATE'),
                    style: ElevatedButton.styleFrom(
                        elevation: 15.0,
                        primary: AppColors.loginSubmit,
                        textStyle:
                            Styles.customTextStyle(Colors.black, 'bold', 18.0)),
                    onPressed: snapshot.data == true && _selectedSubFeatureId != 0 ? doLogin : null,
                  ));
          });
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
          backgroundColor: AppColors.loginSubmit,
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
                                  maxLength: 100,
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Type and Sub-Feature',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    FutureBuilder(
                        future:
                            _features == null ? _fetchFeatureSubData() : null,
                        builder: (context, snapshot) {
                          if (snapshot.hasData || _features != null) {
                            return Column(
                              children: [
                                Card(
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Flex(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        direction: Axis.horizontal,
                                      children: [
                                        Expanded(flex: 1,
                                          child: DropdownButton<int>(
                                            value: _selectedFeatureId,
                                            onChanged: (int newValue) {
                                              if (newValue != 0) {
                                                ticketAddBloc.changeFeature(newValue);
                                                // Set the selectedFeatureId and fetch the sub-features for the selected feature
                                                setState(() {
                                                  _selectedFeatureId = newValue;
                                                  _subFeatures = _features.firstWhere((feature) => feature.featureId == _selectedFeatureId).subFeature;
                                                  _selectedSubFeatureId = 0;
                                                  // ticketAddBloc.changeSubfeature(_subFeatures[0].subFeatureId);

                                                });
                                              }
                                            },
                                            items: _selectedFeatureId == 0
                                                ? [
                                                    DropdownMenuItem<int>(
                                                      value: 0,
                                                      child: Text(
                                                          "Select a Feature"),
                                                    ),
                                                    ..._features.map((feature) {
                                                      return DropdownMenuItem<
                                                          int>(
                                                        value:
                                                            feature.featureId,
                                                        child: Text(feature
                                                            .featureName),
                                                      );
                                                    }).toList(),
                                                  ]
                                                : _features.map((feature) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: feature.featureId,
                                                      child: Text(
                                                          feature.featureName),
                                                    );
                                                  }).toList(),
                                          ),
                                        ),
                                        SizedBox(width: 2.0),
                                        Expanded(flex: 1,
                                          child: DropdownButton<int>(
                                            value: _selectedSubFeatureId,
                                            onChanged: (int newValue) {
                                              if (newValue != 0) {
                                                // Set the selectedSubFeatureId
                                                ticketAddBloc.changeSubfeature(newValue);
                                                // Set the selectedSubFeatureId
                                                setState(() {
                                                  _selectedSubFeatureId = newValue;
                                                });
                                              }
                                            },
                                            items: _selectedSubFeatureId == 0
                                                ? [
                                                    DropdownMenuItem<int>(
                                                      value: 0,
                                                      child: Text(
                                                          "Select a Sub-Feature"),
                                                    ),
                                                    ..._subFeatures
                                                        .map((subFeature) {
                                                      return DropdownMenuItem<
                                                          int>(
                                                        value: subFeature
                                                            .subFeatureId,
                                                        child: Text(subFeature
                                                            .subFeatureName),
                                                      );
                                                    }).toList(),
                                                  ]
                                                : _subFeatures
                                                    .map((subFeature) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: subFeature
                                                          .subFeatureId,
                                                      child: Text(subFeature
                                                          .subFeatureName),
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
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  style: Styles.customTextStyle(
                                      Colors.black, 'bold', 15.0),
                                  decoration: Decorations.textInputDecoration(
                                      StringConst.hintDescription,
                                      snapshot.error,
                                      Colors.white),
                                );
                              })),
                    ),
                    SizedBox(height: 20.0),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            image != null
                                ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: InteractiveViewer(
                                                minScale: 0.5,
                                                maxScale: 2.5,
                                                child: Image.file(File(image.path)),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Image.file(
                                        File(image.path),
                                        fit: BoxFit.cover,
                                        width: MediaQuery.of(context).size.width,
                                        height: 300,
                                      ),
                                    ),
                                  ),
                                ),
                                // Add an ElevatedButton for removing the image
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: AppColors.loginSubmit,
                                    ),
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
                                ),
                              ],
                            )
                                : Text(
                              "No Image",
                              style: TextStyle(fontSize: 20),
                            ),
                            image == null
                                ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.loginSubmit,
                              ),
                                    onPressed: () {
                                      SelectImg();
                                    },
                                    child: Text('Upload Photo'),
                                  )
                                : Container(),
                            //if image not null show the image
                            //if image null show text
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(height: 20.0),
                    responseWidget(),
                    SizedBox(height: 15.0),
                    SizedBox(height: 20.0),
                    eResponse(),
                  ],
                )),
          ),
        ),
        bottomNavigationBar: StreamBuilder(
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
                        Text(StringConst.loading, style: Theme.of(context).textTheme.caption),
                      ],
                    ));
              } else {
                return submitButton();
              }
            }
        )
      ),
    );
  }
}
