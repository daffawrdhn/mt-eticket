import 'package:flutter/material.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/ticket/ticket_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/modelJson/login/login_model.dart' as user;
import 'package:mt/model/response/ticket/tickets_response.dart';
import 'package:mt/provider/ticket/tickets_provider.dart';
import 'package:mt/widget/reuseable/card/card_tickets.dart';
import 'package:mt/model/modelJson/ticket/tickets_model.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';

class ApprovalNav extends StatefulWidget {
  @override
  _ApprovalNavState createState() => _ApprovalNavState();
}

class _ApprovalNavState extends State<ApprovalNav> {

  List<Data> _tickets;
  user.Login _user;

  @override
  void initState() {
    super.initState();
    ticketBloc.resetResponse();
    _user = appData.user;
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: ticketBloc.changeSearchText,
          decoration: InputDecoration(
            hintText: "Search tickets",
            prefixIcon: Icon(Icons.search),
          ),
        ),
        Expanded(
          child: FutureBuilder<TicketsResponse>(
            future: ticketBloc.getApproval(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _tickets = snapshot.data.results.data;
                return _tickets.isEmpty
                    ? Center(child: Text("No tickets found"))
                    : StreamBuilder(
                    stream: ticketBloc.searchText,
                    initialData: "",
                    builder: (context, searchData ) {
                      return TicketsCardList(
                        tickets: _tickets
                            .where((ticket) =>
                        ticket.ticketTitle
                            .toLowerCase()
                            .contains(searchData.data.toLowerCase()) ||
                            ticket.ticketId
                                .toString()
                                .contains(searchData.data))
                            .toList(),
                          type: 'approval', user: _user,
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        errResponse(),
      ],
    );
  }
}