import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/ticket/ticketUpdate_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/modelJson/ticket/tickets_model.dart';
import 'package:mt/model/response/ticket/ticketUpdate_response.dart';
import 'package:mt/resource/values/values.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';

class Ticket extends StatefulWidget {
  final Data ticket;
  final String type;

  Ticket({this.ticket, this.type});
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  void doUpdate(int approval, int id) async {
    FocusScope.of(context).requestFocus(FocusNode());
    // loginBloc.resetResponse();
    ticketUpdateBloc.resetBloc();
    // loginBloc.login();
    ticketUpdateBloc.update(approval, id);
  }

  void popupDialogAlertChange(String message) {
    showAlertDialog(
      context: context,
      message: message == 'null' ? "" : message,
      icon: Icons.done,
      type: 'success',
      onOk: () {
        // Close the dialog
        Navigator.of(context).pop();
        errorBloc.resetBloc();
        // Navigate to the '/login' route and perform an action after the route has been replaced
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      },
    );
  }

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
                subtitle: Text('by ' +
                    ticket.history[index].supervisor.employeeName +
                    'at  ' +
                    DateFormat.yMd().format(
                        DateTime.parse(ticket.history[index].createdAt)) +
                    ' ' +
                    DateFormat.jm().format(
                        DateTime.parse(ticket.history[index].createdAt))),
              );
            },
          ),
        );
      },
    );
  }

  void _update(BuildContext context, String title, int ticketId, int status) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(title),
            content: Container(
              height: 200,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () async {
                      Navigator.pop(context);
                      if (status == 1) {
                        await doUpdate(1, ticketId);
                      } else if (status == 2) {
                        await doUpdate(2, ticketId);
                      } else if (status == 3) {
                        await doUpdate(3, ticketId);
                      } else if (status == 4) {
                        await doUpdate(4, ticketId);
                      }
                    },
                    child: Row(
                      children: [
                        Icon(Icons.done),
                        Text(status == 1
                            ? '  Approve AP1'
                            : status == 2
                                ? '  Approve AP2'
                                : status == 3
                                    ? '  Approve AP3 (Dept Head HCIS)'
                                    : status == 4
                                        ? '  Complete'
                                        : ''),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: status == 3,
                    child: FlatButton(
                      color: Colors.blue,
                      onPressed: () async {
                        await doUpdate(4, ticketId);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                          Text(
                            '  Complete',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FlatButton(
                    color: Colors.red,
                    onPressed: () async {
                      await doUpdate(3, ticketId);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        Text(
                          '  Cancel Ticket',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    AppData().count = 1;
    ticketUpdateBloc.resetBloc();
  }

  @override
  void dispose() {
    // Dispose of any resources here
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget responseWidget() {
    return StreamBuilder<TicketUpdateResponse>(
      stream: ticketUpdateBloc.subject.stream,
      builder: (context, AsyncSnapshot<TicketUpdateResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return Container();
          } else {
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => popupDialogAlertChange(snapshot.data.results.message));
            // Future.microtask(() => Navigator.pushReplacementNamed(context, '/home'));
            return _buildErrorWidget("");
          }
        } else if (appData.errMsg.length > 0) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          error,
          textAlign: TextAlign.center,
          style: Styles.customTextStyle(
              error.contains("berhasil") ? Colors.green : Colors.red,
              'bold',
              14.0),
        ),
      ],
    ));
  }

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
                    SizedBox(
                      height: 10.0,
                    ),
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
                              Text(
                                  'Employee ID: ${widget.ticket.employee.employeeId}'),
                              Text(
                                  'Employee Name: ${widget.ticket.employee.employeeName}'),
                              Text(
                                  'Organization: ${widget.ticket.employee.organization.orgainzationName}'),
                              Text(
                                  'Regional: ${widget.ticket.employee.regional.regionalName}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
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
                                    onPressed: () => _showHistoryModal(
                                        context, widget.ticket),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ],
                              ),
                              Text('ID: ${widget.ticket.ticketId}'),
                              Text(
                                  'Status: ${widget.ticket.ticketStatus.ticketStatusNext}'),
                              Text(
                                  'Feature: ${widget.ticket.feature.featureName}'),
                              Text(
                                  'Sub feature: ${widget.ticket.subFeature.subFeatureName}'),
                              Text(
                                  "Created at: ${DateFormat.yMd().format(DateTime.parse(widget.ticket.createdAt))} ${DateFormat.jm().format(DateTime.parse(widget.ticket.createdAt))}"),
                              SizedBox(
                                height: 8.0,
                              ),
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
                    SizedBox(
                      height: 8.0,
                    ),
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
                              Text(
                                  'Supervisor ID: ${widget.ticket.supervisor.employeeId}'),
                              Text(
                                  'Supervisor Name: ${widget.ticket.supervisor.employeeName}'),
                              Text(
                                  'Organization: ${widget.ticket.supervisor.organization.orgainzationName}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    responseWidget(),
                  ],
                )),
          ),
        ),
        floatingActionButton: Visibility(
          visible: widget.type != 'ticket',
          child: FloatingActionButton.extended(
            label: Text('Action'),
            onPressed: () {
              _update(context, 'Action', widget.ticket.ticketId,
                  widget.ticket.ticketStatusId);
            },
            icon: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
