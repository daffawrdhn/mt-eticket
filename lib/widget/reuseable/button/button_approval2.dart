import 'package:flutter/material.dart';
import 'package:mt/bloc/loading/loading_bloc.dart';

class approvalButton2 extends StatelessWidget {
  final int approval;
  final int ticketId;
  final String employeeId;
  final Function doUpdate;
  final String title;
  final IconData icon;
  final Color buttonColor;

  approvalButton2({
    @required this.approval,
    @required this.ticketId,
    @required this.employeeId,
    @required this.doUpdate,
    @required this.title,
    this.icon = Icons.done,
    this.buttonColor = Colors.green,
  });

  bool close;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: buttonColor,
      onPressed: () async {
        // Show confirmation dialog
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirmation"),
              content: Text("Are you sure you want to"+title+" ?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    close = false;
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("Proceed"),
                  onPressed: () {
                    close = true;
                    Navigator.of(context).pop();
                    doUpdate(approval, ticketId, employeeId);
                  },
                ),
              ],
            );
          },
        );
        if(close == false){
        } else {
          close = null;
          Navigator.of(context).pop();
        }
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}