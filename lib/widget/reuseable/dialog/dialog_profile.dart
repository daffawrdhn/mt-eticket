import 'package:flutter/material.dart';
import 'package:mt/resource/values/values.dart';

Future<void> showProfileDialog({
  @required BuildContext context,
  @required String name,
  @required String email,
  @required String organization,
  @required String regional,
  @required String type,
  @required IconData icon,
  @required VoidCallback onOk,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        //title: Text('Warning'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  children: [
                    Icon(
                      icon,
                      color: type == 'failed' ? Colors.red : Colors.green,
                      size: 50,
                    ),
                    SizedBox(height: 10),
                    Text('Name: ' + name,
                      textAlign: TextAlign.center,
                      style: Styles.customTextStyle(Colors.black, 'normal', 17.0),
                      textScaleFactor: 1.0,
                    ),
                    Text('Email: ' + email,
                      textAlign: TextAlign.center,
                      style: Styles.customTextStyle(Colors.black, 'normal', 17.0),
                      textScaleFactor: 1.0,
                    ),
                    Text('Organization: ' + organization,
                      textAlign: TextAlign.center,
                      style: Styles.customTextStyle(Colors.black, 'normal', 17.0),
                      textScaleFactor: 1.0,
                    ),
                    Text('Regional: ' + regional,
                      textAlign: TextAlign.center,
                      style: Styles.customTextStyle(Colors.black, 'normal', 17.0),
                      textScaleFactor: 1.0,
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(),
                        SizedBox(
                            width: 120,
                            child: ElevatedButton(
                              child: Text(StringConst.ok, textScaleFactor: 1.0,),
                              style: ElevatedButton.styleFrom(
                                  elevation: 10.0,
                                  primary: Colors.green,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                  ),
                                  textStyle: Styles.customTextStyle(Colors.white, 'bold', 18.0)),
                              onPressed: onOk,
                            )
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}