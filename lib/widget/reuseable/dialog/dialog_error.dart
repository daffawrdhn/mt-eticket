import 'package:flutter/material.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';

class eResponse extends StatelessWidget {

  eResponse();

  @override
  Widget build(BuildContext context) {

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

    return StreamBuilder(
      initialData: null,
      stream: errorBloc.errMsg,
      builder: (context, snapshot) {
        if (snapshot.data != null && snapshot.data.toString().length > 1) {
          appData.count = appData.count + 1;
          if (appData.count == 2) {
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
}