import 'package:flutter/material.dart';
import 'package:mt/bloc/loading/loading_bloc.dart';
import 'package:mt/resource/values/values.dart';

class approveButton2 extends StatelessWidget {
  final int approval;
  final int ticketId;
  final String employeeId;
  final Function doUpdate;
  final String title;
  final Color buttonColor;
  final Function closeCallback;

  approveButton2({
    @required this.approval,
    @required this.ticketId,
    @required this.employeeId,
    @required this.doUpdate,
    @required this.title,
    this.buttonColor = AppColors.loginSubmit,
    this.closeCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      child: Material(
        color: buttonColor,
        child: InkWell(
          onTap: () async {
            // Show confirmation dialog
            closeCallback();

            await showDialog(
              context: context,
              builder: (BuildContext context) {

                return AlertDialog(
                  title: Text("Confirmation"),
                  content: Text("Are you sure you want to "+title.toLowerCase()+" ?"),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Cancel",
                        style: TextStyle(
                            color: AppColors.loginSubmit
                        ),),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text("Proceed",
                        style: TextStyle(
                            color: AppColors.loginSubmit
                        ),),
                      onPressed: () {
                        Navigator.of(context).pop();
                        doUpdate(approval, ticketId, employeeId);
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
