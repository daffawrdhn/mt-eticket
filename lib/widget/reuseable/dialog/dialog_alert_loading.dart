import 'package:flutter/material.dart';

Future<void> loadingDialog({
  @required BuildContext context,
  @required String message,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white30,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        elevation: 0.0,
        backgroundColor: Colors.white30,
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
                    CircularProgressIndicator()
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