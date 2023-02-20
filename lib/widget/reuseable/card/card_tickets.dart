import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mt/model/modelJson/login/login_model.dart' as usernow;
import 'package:mt/model/modelJson/ticket/tickets_model.dart';
import 'package:mt/resource/values/values.dart';
import 'package:mt/screen/ticket/ticket_screen.dart';
class TicketsCardList extends StatelessWidget {
  final List<Data> tickets;
  final String type;
  final usernow.Login user;

  TicketsCardList({this.tickets, this.type, this.user});

  @override
  Widget build(BuildContext context) {

    if (tickets.isEmpty) {
      return Center(
        child: Text("No ticket found"),
      );
    }

    return Scrollbar(
      thickness: 10.0,
      child: ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (context, index) {

        final List<Map<String, dynamic>> statusInfo = [
          {'icon': Icons.sticky_note_2_outlined, 'color': Colors.blue[100]},
          {'icon': Icons.looks_one, 'color': Colors.blue[300]},
          {'icon': Icons.looks_two, 'color': Colors.blue[600]},
          {'icon': Icons.looks_3, 'color': Colors.yellow[200]},
          {'icon': Icons.sticky_note_2_rounded, 'color': Colors.yellow[400]},
          {'icon': Icons.sticky_note_2_rounded, 'color': Colors.grey},
          {'icon': Icons.timelapse, 'color': Colors.green[200]},
          {'icon': Icons.done, 'color': Colors.green[600]},
        ];

        final int statusId = tickets[index].ticketStatusId - 1; // Subtract 1 to match list index

        EdgeInsets padding = index == 0 ?
        EdgeInsets.only(left: 8.0,top: 0.0,right: 8.0,bottom: 0.0):
        EdgeInsets.only(left: 8.0,top: 0.0,right: 8.0,bottom: 0.0);
        return Padding(
            padding: padding,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Ticket(ticket: tickets[index], type: type, user: user)));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: ListTile(
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(Icons.arrow_forward),
                  ),
                  subtitle: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          statusInfo[statusId]['icon'],
                          color: statusInfo[statusId]['color'],
                        ),
                        title: Padding(
                          padding: EdgeInsets.only(top: 12.0),
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
                      SizedBox(height: 20.0,),
                    ],
                  ),
                ),
              ),
            )
        );
      },
    ),
    );
  }
}
