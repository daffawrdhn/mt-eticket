import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: buttonColor,
      onPressed: () async {
        doUpdate(approval, ticketId, employeeId);
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