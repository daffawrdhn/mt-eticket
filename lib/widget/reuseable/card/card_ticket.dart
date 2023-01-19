import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mt/model/modelJson/login/login_model.dart' as usernow;
import 'package:mt/model/modelJson/ticket/tickets_model.dart';
import 'package:mt/screen/ticket/ticket_screen.dart';

class TicketsCardList2 extends StatelessWidget {
  final List<Data> tickets;
  final String type;
  final usernow.Login user;

  TicketsCardList2({this.tickets, this.type, this.user});

  @override
  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 3.0,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, top: 0.0, right: 8.0, bottom: 0.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.sticky_note_2_outlined),
                  title: Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(tickets[0].ticketId.toString()),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${tickets[0].ticketTitle}"),
                      Text('Feature: ' + "${tickets[0].feature.featureName}"),
                      Text('Subfeature: ' +
                          "${tickets[0].subFeature.subFeatureName}"),
                      Text('Status: ' +
                          "${tickets[0].ticketStatus.ticketStatusName}"),
                      Visibility(
                        visible: type == 'approval',
                        child: Row(
                          children: [
                            Text('Employee Applicant: '),
                            Text(
                              "${tickets[0].employeeId}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: type == 'ticket',
                        child: Row(
                          children: [
                            Text(
                                "Created At: ${DateFormat.yMd().format(DateTime.parse(tickets[0].createdAt))} ${DateFormat.jm().format(DateTime.parse(tickets[0].createdAt))}"),
                          ],
                        ),
                      ),
                      Text(
                          "Last Update: ${DateFormat.yMd().format(DateTime.parse(tickets[0].history.last.createdAt))} ${DateFormat.jm().format(DateTime.parse(tickets[0].history.last.createdAt))}"),
                    ],
                  ),
                ),
                ButtonBar(
                  children: <Widget>[
                    OutlineButton(
                      child: type == 'ticket'
                          ? Text('VIEW')
                          : (type == 'history'
                              ? Text('CHECK')
                              : Text('APPROVE')),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Ticket(
                                    ticket: tickets[0],
                                    type: type,
                                    user: user)));
                      },
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}
