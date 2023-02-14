import 'package:flutter/material.dart';
import 'package:mt/resource/values/values.dart';

Future<void> showAlertDialog({
  @required BuildContext context,
  @required String message,
  @required String type,
  @required IconData icon,
  @required VoidCallback onOk,
  Color color = Colors.green,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
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
                    Text(message,
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
                                  primary: color,
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