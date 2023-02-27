import 'package:flutter/material.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/ticket/ticket_bloc.dart';
import 'package:mt/data/local/app_data.dart';

class eResponse extends StatelessWidget {

  eResponse();

  @override
  Widget build(BuildContext context) {

    void popupDialogAlert(String message) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      SnackBar snackBar = SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Some code to undo the change.
            errorBloc.resetBloc();
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return StreamBuilder(
      initialData: null,
      stream: errorBloc.errMsg,
      builder: (context, snapshot) {
        if (snapshot.data != null && snapshot.data.toString().length > 1) {
          ticketBloc.resetBloc();
          errorBloc.resetBloc();
          appData.count = appData.count + 1;
          if (appData.count == 2) {
            appData.count = 1;
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