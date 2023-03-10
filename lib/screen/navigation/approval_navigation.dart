import 'package:flutter/material.dart';
import 'package:mt/bloc/ticket/ticket_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/modelJson/login/login_model.dart' as user;
import 'package:mt/model/response/ticket/tickets_response.dart';
import 'package:mt/widget/reuseable/button/button_relogin.dart';
import 'package:mt/widget/reuseable/card/card_tickets.dart';
import 'package:mt/model/modelJson/ticket/tickets_model.dart';
import 'package:mt/widget/reuseable/dialog/dialog_error.dart';
import 'package:mt/widget/reuseable/skeleton/skeleton_ticket.dart';

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
    AppData().count = 1;
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
              await ticketBloc.getApproval();
            },
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
                  return Center( child: reloginButton());
                }
                return Center(child: skeletonTicket());
              },
            ),
          ),
        ),
        eResponse(),
      ],
    );
  }
}