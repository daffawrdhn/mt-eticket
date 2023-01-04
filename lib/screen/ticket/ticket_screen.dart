import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mt/model/modelJson/ticket/tickets_model.dart';

class Ticket extends StatefulWidget {
  final Data ticket;

  Ticket({this.ticket});
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {

  void _showHistoryModal(BuildContext context, Data ticket) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: ListView.builder(
            itemCount: ticket.history.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.done),
                title: Text(ticket.history[index].description != null
                    ? ticket.history[index].description
                    : 'No description provided'),
                subtitle: Text('by ' + ticket.history[index].supervisor.employeeName + 'at  ' + DateFormat.yMd().format(DateTime.parse(ticket.history[index].createdAt)) + ' ' + DateFormat.jm().format(DateTime.parse(ticket.history[index].createdAt))),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ticket: ID${widget.ticket.ticketId}'),
        ),
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0,),
                    Container(
                      width: double.infinity,
                      child: Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'APPLICANT',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text('Employee ID: ${widget.ticket.employee.employeeId}'),
                              Text('Employee Name: ${widget.ticket.employee.employeeName}'),
                              Text('Organization: ${widget.ticket.employee.organization.orgainzationName}'),
                              Text('Regional: ${widget.ticket.employee.regional.regionalName}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    Container(
                      width: double.infinity,
                      child: Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'TICKET',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Spacer(),
                                  OutlineButton(
                                    child: Text(
                                      'History',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    onPressed: () => _showHistoryModal(context, widget.ticket),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ],
                              ),
                              Text('ID: ${widget.ticket.ticketId}'),
                              Text('Status: ${widget.ticket.ticketStatus.ticketStatusName}'),
                              Text('Feature: ${widget.ticket.feature.featureName}'),
                              Text('Sub feature: ${widget.ticket.subFeature.subFeatureName}'),
                              Text("Created at: ${DateFormat.yMd().format(DateTime.parse(widget.ticket.createdAt))} ${DateFormat.jm().format(DateTime.parse(widget.ticket.createdAt))}"),
                              SizedBox(height: 8.0,),
                              Text('Title: ${widget.ticket.ticketTitle}'),
                              Text('${widget.ticket.ticketDescription}'),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                        physics: ClampingScrollPhysics(),
                                        child: Container(
                                          height: 300,
                                          child: Image.network(
                                            'http://10.0.2.1/storage/${widget.ticket.photo}',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Image.network(
                                  'http://10.0.2.1/storage/${widget.ticket.photo}',
                                  height: 300,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    Container(
                      width: double.infinity,
                      child: Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'SUPERVISOR',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text('Supervisor ID: ${widget.ticket.supervisor.employeeId}'),
                              Text('Supervisor Name: ${widget.ticket.supervisor.employeeName}'),
                              Text('Organization: ${widget.ticket.supervisor.organization.orgainzationName}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0,),
                  ],
                )
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
          tooltip: 'Add Post',
          child: Icon(Icons.add),
        ),
      ),
    );

  }
}