import 'package:flutter/material.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/ticket/ticket_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/response/ticket/tickets_response.dart';
import 'package:mt/provider/ticket/tickets_provider.dart';
import 'package:mt/widget/reuseable/card/card_tickets.dart';
import 'package:mt/model/modelJson/ticket/tickets_model.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';

class TicketsNav extends StatefulWidget {
  @override
  _TicketsNavState createState() => _TicketsNavState();
}

class _TicketsNavState extends State<TicketsNav> {
  final TextEditingController _searchController = TextEditingController();

  String _searchText = "";

  @override
  void initState() {
    super.initState();
    AppData().count = 1;
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
            WidgetsBinding.instance
                .addPostFrameCallback((_) => popupDialogAlert(snapshot.data));
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
    return FutureBuilder<TicketsResponse>(
      future: ticketBloc.get(),
      builder: (BuildContext context, AsyncSnapshot<TicketsResponse> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              TextField(
                controller: _searchController,
              onChanged: (text) {
                  ticketBloc.changeSearchText(text);
                },
                decoration: InputDecoration(
                  hintText: "Search tickets",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: ticketBloc.searchText,
                  builder: (context, searchSnapshot) {
                    if (!searchSnapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    _searchText = searchSnapshot.data;
                    return FutureBuilder<TicketsResponse>(
                      future: ticketBloc.get(),
                      builder: (BuildContext context, AsyncSnapshot<TicketsResponse> snapshot) {
                        if (snapshot.hasData) {
                          final filteredTickets = snapshot.data.results.data
                              .where((ticket) =>
                          ticket.ticketTitle
                              .toLowerCase()
                              .contains(_searchText.toLowerCase()) ||
                              ticket.ticketId
                                  .toString()
                                  .contains(_searchText))
                              .toList();
                          return filteredTickets.isEmpty
                              ? Center(child: Text("No tickets found"))
                              : TicketsCardList(
                              tickets: filteredTickets,
                              type: 'ticket');
                        } else if (snapshot.hasError) {
                          return errResponse();
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    );
                  },
                ),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return errResponse();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
