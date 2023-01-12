import 'package:flutter/material.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/modelJson/login/login_model.dart' as user;
import 'package:mt/model/response/ticket/tickets_response.dart';
import 'package:mt/provider/ticket/tickets_provider.dart';
import 'package:mt/widget/reuseable/card/card_tickets.dart';
import 'package:mt/model/modelJson/ticket/tickets_model.dart';

class ApprovalNav extends StatefulWidget {
  @override
  _ApprovalNavState createState() => _ApprovalNavState();
}

class _ApprovalNavState extends State<ApprovalNav> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  List<Data> _tickets;
  user.Login _user;

  @override
  void initState() {
    super.initState();
    _user = appData.user;
    TicketsProvider ticketsProvider = TicketsProvider();
    Future<TicketsResponse> ticketsResponse = ticketsProvider.getApproval();
    ticketsResponse.then((response) {
      setState(() {
        _tickets = response.results.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _searchController,
          onChanged: (text) {
            setState(() {
              _searchText = text;
            });
          },
          decoration: InputDecoration(
            hintText: "Search tickets",
            prefixIcon: Icon(Icons.search),
          ),
        ),
        Expanded(
          child: _tickets == null
              ? Center(child: CircularProgressIndicator())
              : _tickets.isEmpty
              ? Center(child: Text("No tickets found"))
              : TicketsCardList(
            tickets: _tickets
                .where((ticket) =>
            ticket.ticketTitle
                .toLowerCase()
                .contains(_searchText.toLowerCase()) ||
                ticket.ticketId
                    .toString()
                    .contains(_searchText))
                .toList(), type: 'approval', user: _user,
          ),
        ),
      ],
    );
  }
}
