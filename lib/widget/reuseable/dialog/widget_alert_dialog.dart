import 'package:flutter/material.dart';
import '../../../resource/values/values.dart';

class WidgetAlertDialog extends StatelessWidget {
  final String message;
  final String onTextPositiveButton;
  final String onTextNegativeButton;
  final VoidCallback onOk;
  final VoidCallback onCancel;
  final String type;

  const WidgetAlertDialog({Key key, this.message, this.onTextPositiveButton, this.onTextNegativeButton, this.onOk, this.onCancel, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        color: Colors.transparent,
        height: message.length > 100 ? 320 : message.length > 50 ? 250 : 220,
        width: 300,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    type == 'failed' ? Icons.cancel : Icons.check_circle,
                    color: type == 'failed' ? Colors.red : Colors.green,
                    size: 60,
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: type == 'failed' ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                    children: [
                      type == 'failed' ?
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          child: Text(onTextNegativeButton, textScaleFactor: 1.0,),
                          style: ElevatedButton.styleFrom(
                              elevation: 15.0,
                              primary: Colors.red,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              textStyle: Styles.customTextStyle(Colors.white, 'bold', 18.0)),
                          onPressed: onCancel,
                        ),
                      ) : Container(),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          child: Text(onTextPositiveButton, textScaleFactor: 1.0,),
                          style: ElevatedButton.styleFrom(
                              elevation: 15.0,
                              primary: AppColors.primaryColor,
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
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }
}