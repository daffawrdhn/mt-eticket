import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/ticket/ticket_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/response/ticket/tickets_response.dart';
import 'package:mt/provider/ticket/tickets_provider.dart';
import 'package:mt/widget/reuseable/card/card_tickets.dart';
import 'package:mt/model/modelJson/ticket/tickets_model.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';
import 'package:mt/widget/reuseable/dialog/dialog_error.dart';

class TicketsNav extends StatefulWidget {
  @override
  _TicketsNavState createState() => _TicketsNavState();
}

class _TicketsNavState extends State<TicketsNav> {

  List<Data> _tickets;

  @override
  void initState() {
    super.initState();
    ticketBloc.resetResponse();
    AppData().count = 1;
  }

  @override
  void dispose() {
    super.dispose();
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
          child: RefreshIndicator(
            onRefresh: () async {
              ticketBloc.resetResponse();
              await ticketBloc.get();
            },
            child: FutureBuilder<TicketsResponse>(
              future: ticketBloc.get(),
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
                          type: 'ticket',
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error));
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
        eResponse(),
      ],
    );
  }
}
