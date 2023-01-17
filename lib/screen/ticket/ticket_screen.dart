import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/ticket/ticketUpdate_bloc.dart';
import 'package:mt/bloc/ticket/ticket_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/modelJson/login/login_model.dart' as usernow;
import 'package:mt/model/modelJson/ticket/helpdesk_model.dart' as helpdesk;
import 'package:mt/model/modelJson/ticket/pic_model.dart' as pic;
import 'package:mt/model/modelJson/ticket/tickets_model.dart';
import 'package:mt/model/response/ticket/helpdesk_response.dart';
import 'package:mt/model/response/ticket/pic_response.dart';
import 'package:mt/model/response/ticket/ticketUpdate_response.dart';
import 'package:mt/provider/ticket/tickets_provider.dart';
import 'package:mt/resource/values/values.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';

class Ticket extends StatefulWidget {
  final Data ticket;
  final String type;
  final usernow.Login user;

  Ticket({this.ticket, this.type, this.user});
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {

  //HCIS Dept Head
  String _hcisdh = '000000000';

  // Declare a variable to store the selected feature ID
  String _selectedPics;
  String _selectedHelpdesks;

  // Declare a list of Feature objects to store the fetched data
  List<pic.PIC> _pics;
  List<helpdesk.HELPDESK> _helpdesks;

  Future<Uint8List> _imageFuture;

  TicketsProvider _tickets = TicketsProvider();

  _fetchFeaturePics(int regionalId) async {
    try {
      PicResponse response = await _tickets.getPics(regionalId);
      // Ensure that employeeIds are unique
      Set<String> uniqueIds = Set();
      _pics = response.results.data.pIC.where((pic) {
        if (uniqueIds.contains(pic.employeeId)) {
          return false;
        }
        uniqueIds.add(pic.employeeId);
        return true;
      }).toList();
      setState(() {
        _selectedPics = '0';
      });
    } catch (error) {
      // Handle the error
      errorBloc.updateErrMsg('Failed Get PICs data');
    }
  }

  _fetchFeatureHelpdesks(int regionalId) async {
    try {
      HelpdeskResponse response = await _tickets.getHelpdesks(regionalId);
      // Ensure that employeeIds are unique
      Set<String> uniqueIds = Set();
      _helpdesks = response.results.data.hELPDESK.where((helpdesk) {
        if (uniqueIds.contains(helpdesk.employeeId)) {
          return false;
        }
        uniqueIds.add(helpdesk.employeeId);
        return true;
      }).toList();
      setState(() {
        _selectedHelpdesks = '0';
      });
    } catch (error) {
      // Handle the error
      errorBloc.updateErrMsg('Failed Get PICs data');
    }
  }

  void doUpdate(int approval, int id, String EmployeeId) async {
    FocusScope.of(context).requestFocus(FocusNode());
    ticketUpdateBloc.resetBloc();
    ticketUpdateBloc.update(approval, id, EmployeeId);
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
                    ' at ' +
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

  void _update(BuildContext context, String title, int ticketId, int status,
      String employeeId) {
    showDialog(
        context: context,
        useSafeArea: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(title),
            content: Container(
              child: Column(
                children: [

                  //PIC REGIONAL
                  Visibility(
                    visible: status == 1,
                    child: Column(
                      children: [
                        FutureBuilder(
                          future: _fetchFeaturePics(
                              widget.ticket.employee.regional.regionalId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData || _pics != null) {
                              return StatefulBuilder(
                                builder: (BuildContext context, setState) {
                                  return Column(
                                    children: [
                                      Text('Ticket Status: ' +
                                          status.toString()),
                                      Card(
                                        elevation: 0.0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Flex(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              direction: Axis.horizontal,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: DropdownButton<String>(
                                                    value: _selectedPics,
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        _selectedPics =
                                                            newValue;
                                                      });
                                                      if (_selectedPics !=
                                                          '0') {
                                                        ticketBloc.changePic(
                                                            newValue);
                                                      } else {
                                                        ticketBloc.resetBloc();
                                                      }
                                                    },
                                                    items: [
                                                      DropdownMenuItem<String>(
                                                        value: '0',
                                                        child:
                                                            Text('Select PIC'),
                                                      ),
                                                      ..._pics.map((pic) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: pic.employeeId,
                                                          child: Text(pic
                                                                  .employeeName +
                                                              ' - ' +
                                                              pic.employeeId),
                                                        );
                                                      }).toList()
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 2.0),
                                              ]),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                        StreamBuilder(
                          stream: ticketBloc.pic,
                          builder: (context, snapshot) {
                            return Visibility(
                              visible: snapshot.hasData,
                              child: FlatButton(
                                color: Colors.blue,
                                onPressed: snapshot.hasData
                                    ? () async {
                                        doUpdate(1, ticketId, _selectedPics);
                                      }
                                    : null,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '  Sent to PIC  ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              replacement: FlatButton(
                                color: Colors.grey,
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '  Sent to PIC  ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  //HELPDESK
                  Visibility(
                    visible: status == 2,
                    child: Column(
                      children: [
                        FutureBuilder(
                          future: _fetchFeatureHelpdesks(widget.ticket.employee.regional.regionalId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData || _helpdesks != null) {
                              return StatefulBuilder(
                                builder: (BuildContext context, setState) {
                                  return Column(
                                    children: [
                                      Text('Ticket Status: ' +
                                          status.toString()),
                                      Card(
                                        elevation: 0.0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Flex(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              direction: Axis.horizontal,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: DropdownButton<String>(
                                                    value: _selectedHelpdesks,
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        _selectedHelpdesks =
                                                            newValue;
                                                      });
                                                      if (_selectedHelpdesks != '0') {
                                                        ticketBloc.changeHelpdesk(newValue);
                                                      } else {
                                                        ticketBloc.resetBloc();
                                                      }
                                                    },
                                                    items: [
                                                      DropdownMenuItem<String>(
                                                        value: '0',
                                                        child:
                                                        Text('Select Helpdesk'),
                                                      ),
                                                      ..._helpdesks.map((helpdesk) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: helpdesk.employeeId,
                                                          child: Text(helpdesk
                                                              .employeeName +
                                                              ' - ' +
                                                              helpdesk.employeeId),
                                                        );
                                                      }).toList()
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 2.0),
                                              ]),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                        StreamBuilder(
                          stream: ticketBloc.helpdesk,
                          builder: (context, snapshot) {
                            return Visibility(
                              visible: snapshot.hasData,
                              child: FlatButton(
                                color: Colors.blue,
                                onPressed: snapshot.hasData
                                    ? () async {
                                  doUpdate(2, ticketId, _selectedHelpdesks);
                                }
                                    : null,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '  Sent to Helpdesk  ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              replacement: FlatButton(
                                color: Colors.grey,
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '  Sent to Helpdesk  ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  Visibility(visible: status == 3, child: FlatButton(
                    color: Colors.green,
                    onPressed: () async {
                      doUpdate(3, ticketId, _hcisdh);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                        Text(
                          '  Sent to HCIS Dept Head  ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  ),

                  SizedBox(height: 5),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 5),

                  FlatButton(
                    color: Colors.green,
                    onPressed: () async {
                      doUpdate(4, ticketId, widget.user.data.employeeId);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                        Text(
                          '  Final Approve  ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  FlatButton(
                    color: Colors.red,
                    onPressed: () async {
                      doUpdate(5, ticketId, widget.user.data.employeeId);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        Text(
                          '  Reject',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        }).then((val) {
      // This code will be executed when the dialog is closed
      // You can do some post-processing of the data here, or perform some other action
      ticketBloc.resetBloc();
    });
  }

  void popupDialogAlert(String message){
    showAlertDialog(
      context: context,
      message: message == 'null' ? "" : message,
      icon: Icons.info_outline,
      type: 'failed',
      onOk: (){
        Navigator.pop(context);
        errorBloc.resetBloc();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _imageFuture = TicketsProvider().getPhoto(widget.ticket.ticketId);
    AppData().count = 1;
    ticketUpdateBloc.resetBloc();
    ticketBloc.resetBloc();
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

  Widget errResponse(){
    return StreamBuilder(
      initialData: null,
      stream: errorBloc.errMsg,
      builder: (context, snapshot) {
        if (snapshot.data != null && snapshot.data.toString().length > 1) {
          appData.count = appData.count + 1;
          if(appData.count == 2){
            appData.count = 0;
            WidgetsBinding.instance.addPostFrameCallback((_) => popupDialogAlert(snapshot.data));
          }
          return Container();
        } else {
          return Container();
        }
      },
    );
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
                                'EMPLOYEE',
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
                                  'Organization: ${widget.ticket.employee.organization.organizationName}'),
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
                              Text(
                                  "Last Update: ${DateFormat.yMd().format(DateTime.parse(widget.ticket.history.last.createdAt))} ${DateFormat.jm().format(DateTime.parse(widget.ticket.history.last.createdAt))}"),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('Title: ${widget.ticket.ticketTitle}'),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('${widget.ticket.ticketDescription}'),
                              SizedBox(
                                height: 8.0,
                              ),
                        FutureBuilder(
                          future: _imageFuture,
                          builder: (context, image) {
                            if (image.connectionState == ConnectionState.done) {
                              if (image.hasData && image.data != null) {
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: InteractiveViewer(
                                            maxScale: 2.5,
                                            minScale: 0.5,
                                            child: Image.memory(
                                              image.data,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Image.memory(
                                    image.data,
                                    height: 300,
                                  ),
                                );
                              } else {
                                return Text('No Picture Uploaded');
                              }
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),

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
                                  'Organization: ${widget.ticket.supervisor.organization.organizationName}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    responseWidget(),
                    errResponse(),
                  ],
                )),
          ),
        ),
        floatingActionButton: Visibility(
          visible: widget.type != 'ticket',
          child: FloatingActionButton.extended(
            label: Text('Action'),
            onPressed: () {
              _update(context, 'Select Approval', widget.ticket.ticketId,
                  widget.ticket.ticketStatusId, widget.ticket.employeeId);
            },
            icon: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
