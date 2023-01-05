import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mt/model/modelJson/ticket/tickets_model.dart';
import 'package:mt/screen/ticket/ticket_screen.dart';
class TicketsCardList extends StatelessWidget {
  final List<Data> tickets;
  final String type;

  TicketsCardList({this.tickets, this.type});

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
                        Text("Created at: ${DateFormat.yMd().format(DateTime.parse(tickets[index].createdAt))} ${DateFormat.jm().format(DateTime.parse(tickets[index].createdAt))}"),
                      ],
                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      OutlineButton(
                        child: type == 'ticket' ? Text('VIEW') : Text('APPROVE'),
                        onPressed: () {
                          if (type == 'ticket') {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Ticket(ticket: tickets[index], type: 'ticket')));
                          } else if (type == 'approval') {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Ticket(ticket: tickets[index], type: 'approval')));
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
