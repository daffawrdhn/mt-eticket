import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mt/model/modelJson/login/login_model.dart' as usernow;
import 'package:mt/model/modelJson/ticket/tickets_model.dart';
import 'package:mt/screen/ticket/ticket_screen.dart';
class TicketsCardList extends StatelessWidget {
  final List<Data> tickets;
  final String type;
  final usernow.Login user;

  TicketsCardList({this.tickets, this.type, this.user});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        EdgeInsets padding = index == 0 ? EdgeInsets.only(left: 8.0,top: 16.0,right: 8.0,bottom: 10.0) : EdgeInsets.only(left: 8.0,top: 0.0,right: 8.0,bottom: 10.0);
        return Padding(
          padding: padding,
          child: Card(
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0,top: 0.0,right: 8.0,bottom: 0.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.sticky_note_2_outlined),
                    title: Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(tickets[index].ticketId.toString()),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("${tickets[index].ticketTitle}"),
                        Text('Feature: '+ "${tickets[index].feature.featureName}"),
                        Text('Subfeature: ' + "${tickets[index].subFeature.subFeatureName}"),
                        Text('Status: ' + "${tickets[index].ticketStatus.ticketStatusName}"),
                        Visibility(visible: type == 'approval',
                          child: Row( children: [
                            Text('Employee Applicant: '),
                            Text(
                              "${tickets[index].employeeId}",
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                          ],
                          ),
                        ),
                        Visibility(visible: type == 'ticket',
                          child: Row( children: [
                            Text("Created At: ${DateFormat.yMd().format(DateTime.parse(tickets[index].createdAt))} ${DateFormat.jm().format(DateTime.parse(tickets[index].createdAt))}"),
                          ],
                          ),
                        ),
                        Text("Last Update: ${DateFormat.yMd().format(DateTime.parse(tickets[index].history.last.createdAt))} ${DateFormat.jm().format(DateTime.parse(tickets[index].history.last.createdAt))}"),
                      ],
                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      OutlineButton(
                        child: type == 'ticket' ? Text('VIEW') : Text('APPROVE'),
                        onPressed: () {
                          if (type == 'ticket') {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Ticket(ticket: tickets[index], type: 'ticket', user: user)));
                          } else if (type == 'approval') {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Ticket(ticket: tickets[index], type: 'approval', user: user)));
                          }
                        },
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
