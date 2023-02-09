import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/loading/loading_bloc.dart';
import 'package:mt/bloc/ticket/ticketUpdate_bloc.dart';
import 'package:mt/bloc/ticket/ticket_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/modelJson/login/login_model.dart' as usernow;
import 'package:mt/model/modelJson/ticket/depthead_model.dart' as depthead;
import 'package:mt/model/modelJson/ticket/helpdesk_model.dart' as helpdesk;
import 'package:mt/model/modelJson/ticket/pic_model.dart' as pic;
import 'package:mt/model/modelJson/ticket/tickets_model.dart';
import 'package:mt/model/response/ticket/depthead_response.dart';
import 'package:mt/model/response/ticket/helpdesk_response.dart';
import 'package:mt/model/response/ticket/pic_response.dart';
import 'package:mt/model/response/ticket/ticketUpdate_response.dart';
import 'package:mt/provider/ticket/tickets_provider.dart';
import 'package:mt/resource/values/values.dart';
import 'package:mt/widget/reuseable/button/button_approval.dart';
import 'package:mt/widget/reuseable/button/button_approval2.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert_loading.dart';
import 'package:mt/widget/reuseable/expandable/expandable_card.dart';
import 'package:mt/widget/reuseable/text/text_detail.dart';
import 'package:mt/widget/reuseable/text/text_detailed.dart';
import 'package:photo_view/photo_view.dart';

class Ticket extends StatefulWidget {
  final Data ticket;
  final String type;
  final usernow.Login user;

  Ticket({this.ticket, this.type, this.user});
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  // Declare a variable to store the selected list
  String _selectedPics;
  String _selectedHelpdesks;
  String _selectedDepthead;

  // Declare a list of Feature objects to store the fetched data
  List<pic.PIC> _pics;
  List<helpdesk.HELPDESK> _helpdesks;
  List<depthead.DEPTHEAD> _depthead;

  Future<Uint8List> _imageFuture;

  _fetchFeaturePics(int regionalId) async {
    PicResponse response = await ticketBloc.getPics(regionalId.toString());
    // Ensure that employeeIds are unique
    Set<String> uniqueIds = Set();
    _pics = response.results.data.pIC.where((pic) {
      if (uniqueIds.contains(pic.employeeId)) {
        return false;
      }
      uniqueIds.add(pic.employeeId);
      return true;
    }).toList();
    _selectedPics = '0';
  }

  _fetchFeatureHelpdesks(int regionalId) async {
    HelpdeskResponse response =
        await ticketBloc.getHelpdesks(regionalId.toString());
    // Ensure that employeeIds are unique
    Set<String> uniqueIds = Set();
    _helpdesks = response.results.data.hELPDESK.where((helpdesk) {
      if (uniqueIds.contains(helpdesk.employeeId)) {
        return false;
      }
      uniqueIds.add(helpdesk.employeeId);
      return true;
    }).toList();
    _selectedHelpdesks = '0';
  }

  _fetchFeatureDepthead() async {
    DeptheadResponse response = await ticketBloc.getDepthead();
    // Ensure that employeeIds are unique
    Set<String> uniqueIds = Set();
    _depthead = response.results.data.dEPTHEAD.where((depthead) {
      if (uniqueIds.contains(depthead.employeeId)) {
        return false;
      }
      uniqueIds.add(depthead.employeeId);
      return true;
    }).toList();
    _selectedDepthead = '0';
  }

  void doUpdate(int approval, int id, String EmployeeId) async {
    FocusScope.of(context).requestFocus(FocusNode());
    ticketUpdateBloc.resetBloc();
    ticketUpdateBloc.update(approval, id, EmployeeId);
  }

  void popupDialogAlertChange(String message) {
    showAlertDialog(
      color: Colors.blue,
      context: context,
      message: message == 'null' ? "" : message,
      icon: message.toLowerCase().contains("reject") ? Icons.sticky_note_2_outlined : Icons.done,
      type: message.toLowerCase().contains("reject") ? 'failed' : 'success',
      onOk: () {
        // Close the dialog
        Navigator.of(context).pop();
        errorBloc.resetBloc();
        // Navigate to the '/login' route and perform an action after the route has been replaced
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      },
    );
  }

  void popupLoading(String message) {
    loadingDialog(
      context: context,
      message: message == 'null' ? "" : message,
    );
  }

  void closePopupLoading() {
    Navigator.pop(context);
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
                subtitle: Text(ticket.history[index].supervisor.employeeId ==
                        appData.user.data.employeeId
                    ? 'by You at ' +
                        DateFormat.yMd().format(
                            DateTime.parse(ticket.history[index].createdAt)) +
                        ' ' +
                        DateFormat.jm().format(
                            DateTime.parse(ticket.history[index].createdAt))
                    : 'by ' +
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

  Widget _update(BuildContext context) {
    showDialog(
        context: context,
        useSafeArea: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Menu'),
            content: Container(
              child: Column(
                children: [
                  //PIC REGIONAL
                  Visibility(
                    visible: widget.ticket.ticketStatusId == 1,
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
                                                        _selectedPics = newValue;
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

                        //PIC BUTTON APPROVAL
                        approvalButton(
                          stream: ticketBloc.pic,
                          title: 'Sent to PIC',
                          ticketId: widget.ticket.ticketId,
                          idapproval: 1,
                          doUpdate: doUpdate,
                        ),
                      ],
                    ),
                  ),

                  //HELPDESK
                  Visibility(
                    visible: widget.ticket.ticketStatusId == 2,
                    child: Column(
                      children: [
                        FutureBuilder(
                          future: _fetchFeatureHelpdesks(
                              widget.ticket.employee.regional.regionalId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData || _helpdesks != null) {
                              return StatefulBuilder(
                                builder: (BuildContext context, setState) {
                                  return Column(
                                    children: [
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
                                                        _selectedHelpdesks = newValue;
                                                      });
                                                      if (_selectedHelpdesks !=
                                                          '0') {
                                                        ticketBloc
                                                            .changeHelpdesk(
                                                                newValue);
                                                      } else {
                                                        ticketBloc.resetBloc();
                                                      }
                                                    },
                                                    items: [
                                                      DropdownMenuItem<String>(
                                                        value: '0',
                                                        child: Text(
                                                            'Select Helpdesk'),
                                                      ),
                                                      ..._helpdesks
                                                          .map((helpdesk) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: helpdesk
                                                              .employeeId,
                                                          child: Text(helpdesk
                                                                  .employeeName +
                                                              ' - ' +
                                                              helpdesk
                                                                  .employeeId),
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

                        //HELPDESK BUTTON APPROVAL
                        approvalButton(
                          stream: ticketBloc.helpdesk,
                          title: '  Sent to Helpdesk  ',
                          ticketId: widget.ticket.ticketId,
                          idapproval: 2,
                          doUpdate: doUpdate,
                        ),
                      ],
                    ),
                  ),

                  //DEPTHEAD
                  Visibility(
                    visible: widget.ticket.ticketStatusId == 3,
                    child: Column(
                      children: [
                        FutureBuilder(
                          future: _fetchFeatureDepthead(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData || _depthead != null) {
                              return StatefulBuilder(
                                builder: (BuildContext context, setState) {
                                  return Column(
                                    children: [
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
                                                    value: _selectedDepthead,
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        _selectedDepthead = newValue;
                                                      });
                                                      if (_selectedDepthead !=
                                                          '0') {
                                                        ticketBloc
                                                            .changeDepthead(
                                                                newValue);
                                                      } else {
                                                        ticketBloc.resetBloc();
                                                      }
                                                    },
                                                    items: [
                                                      DropdownMenuItem<String>(
                                                        value: '0',
                                                        child: Text(
                                                            'Select DeptHead'),
                                                      ),
                                                      ..._depthead
                                                          .map((depthead) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: depthead
                                                              .employeeId,
                                                          child: Text(depthead
                                                                  .employeeName +
                                                              ' - ' +
                                                              depthead
                                                                  .employeeId),
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

                        //DEPT HEAD BUTTON APPROVAL
                        approvalButton(
                          stream: ticketBloc.depthead,
                          title: 'Sent to Depthead',
                          ticketId: widget.ticket.ticketId,
                          idapproval: 3,
                          doUpdate: doUpdate,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 5),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 5),

                  //FINAL APPROVE BUTTON
                  Visibility(
                    visible: widget.ticket.ticketStatusId == 3 ||
                        widget.ticket.ticketStatusId == 4,
                    child: approvalButton2(
                        approval: 4,
                        ticketId: widget.ticket.ticketId,
                        employeeId: widget.user.data.employeeId,
                        doUpdate: doUpdate,
                        title: 'Final Approve'),
                  ),

                  //REJECT BUTTON
                  approvalButton2(
                      approval: 5,
                      ticketId: widget.ticket.ticketId,
                      employeeId: widget.user.data.employeeId,
                      doUpdate: doUpdate,
                      title: 'Reject',
                      icon: Icons.close,
                      buttonColor: Colors.red),
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

  void popupDialogAlert(String message) {
    showAlertDialog(
      context: context,
      message: message == 'null' ? "" : message,
      icon: Icons.info_outline,
      type: 'failed',
      onOk: () {
        Navigator.pop(context);
        errorBloc.resetBloc();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    AppData().count = 1;
    ticketUpdateBloc.resetBloc();
    ticketBloc.resetBloc();
    _imageFuture = ticketBloc.getFoto(widget.ticket.ticketId);
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

  Widget errResponse() {
    return StreamBuilder(
      initialData: null,
      stream: errorBloc.errMsg,
      builder: (context, snapshot) {
        if (snapshot.data != null && snapshot.data.toString().length > 1) {
          appData.count = appData.count + 1;
          if (appData.count == 2) {
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
            WidgetsBinding.instance.addPostFrameCallback((_) => popupDialogAlertChange(snapshot.data.results.message));
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

  Widget _buildLoadingWidget() {
    return StreamBuilder(
        stream: loadingBloc.isLoading,
        builder: (context, snapshot) {
          if(snapshot.data == true){
            WidgetsBinding.instance.addPostFrameCallback((_) => popupLoading('Loading...'));
            return Container();
          }else{
            return Container();
          }
        }
    );
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

                    _buildLoadingWidget(),
                    SizedBox(
                      height: 8.0,
                    ),

                    //EMPLOYEE
                    ExpandableCard(
                      icon: Icon(Icons.person),
                      title: 'EMPLOYEE',
                      titleBold: true,
                      textList: [
                        'Employee ID: ${widget.ticket.employee.employeeId}',
                        'Employee Name: ${widget.ticket.employee.employeeName}',
                        'Organization: ${widget.ticket.employee.organization.organizationName}',
                        'Regional: ${widget.ticket.employee.regional.regionalName}'
                      ],
                    ),

                    SizedBox(
                      height: 8.0,
                    ),

                    //SUPERVISOR
                    ExpandableCard(
                      icon: Icon(Icons.supervisor_account),
                      title: 'SUPERVISOR',
                      titleBold: true,
                      textList: [
                        'Supervisor ID: ${widget.ticket.supervisor.employeeId}',
                        'Supervisor Name: ${widget.ticket.supervisor.employeeName}',
                        'Organization: ${widget.ticket.supervisor.organization.organizationName}'
                      ],
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
                                    'TICKET - ' +
                                        widget.ticket.ticketId.toString(),
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
                              textDetail(label: 'Status', initialValue: widget.ticket.ticketStatus.ticketStatusNext),
                              Visibility(
                                visible: widget.ticket.ticketStatusId != 5 && widget.ticket.ticketStatusId != 6,
                                child: textDetail(label: 'Current Approval', initialValue: widget.ticket.supervisorId == appData.user.data.employeeId ? 'You' : widget.ticket.supervisorId + ' - ' + widget.ticket.currentapproval.employeeName),
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: textDetail(label: 'Type', initialValue: widget.ticket.feature.featureName),) ,
                                  Expanded(
                                    flex: 1,
                                    child: textDetail(label: 'Sub-Feature', initialValue: widget.ticket.subFeature.subFeatureName),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: textDetail(label: 'Created at', initialValue: DateFormat.yMd().format(DateTime.parse(widget.ticket.createdAt))+ ' ' +DateFormat.jm().format(DateTime.parse(widget.ticket.createdAt))),) ,
                                  Expanded(
                                    flex: 1,
                                    child: textDetail(label: 'Last Update', initialValue: DateFormat.yMd().format(DateTime.parse(widget.ticket.history.last.createdAt))+ ' ' +DateFormat.jm().format(DateTime.parse(widget.ticket.history.last.createdAt))),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Divider(
                                color: Colors.blue,
                                height: 10,
                                thickness: 1.0,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              textDetailed(label: 'Title', text: widget.ticket.ticketTitle),
                              textDetailed(label: 'Description', text: widget.ticket.ticketDescription),
                              SizedBox(
                                height: 8.0,
                              ),
                              Divider(
                                color: Colors.blue,
                                height: 10,
                                thickness: 1.0,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('PHOTO',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Center(
                                  child: FutureBuilder<Uint8List>(
                                    future: _imageFuture,
                                    builder: (context, AsyncSnapshot<Uint8List> image) {
                                      if (image.connectionState == ConnectionState.done) {
                                        if (image.hasData && image.data != null) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) {
                                                    return Scaffold(
                                                      appBar: AppBar(
                                                        title: Text("Picture - ID "+widget.ticket.ticketId.toString()),
                                                      ),
                                                      body: Container(
                                                        child: PhotoView(
                                                          enableRotation: true,
                                                          imageProvider: MemoryImage(image.data),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 16.0,
                    ),
                    responseWidget(),
                    errResponse(),
                  ],
                )),
          ),
        ),
        floatingActionButton: Visibility(
          visible: widget.type == 'approval',
          child: FloatingActionButton.extended(
            label: Text('Action'),
            onPressed: () {
              _update(context);
            },
            icon: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
