import 'package:flutter/material.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/ticket/ticket_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/modelJson/login/login_model.dart' as user;
import 'package:mt/model/response/ticket/tickets_response.dart';
import 'package:mt/provider/ticket/tickets_provider.dart';
import 'package:mt/resource/values/values.dart';
import 'package:mt/widget/reuseable/card/card_tickets.dart';
import 'package:mt/model/modelJson/ticket/tickets_model.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';
import 'package:mt/widget/reuseable/dialog/dialog_error.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  List<Data> _tickets;

  @override
  void initState() {
    super.initState();
    ticketBloc.resetResponse();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.loginSubmit,
        title: Text('History'),
      ),
      body: Center(child: history(),),
    );
  }

  Widget history(){
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
              await ticketBloc.getHistory();
            },
            child: FutureBuilder<TicketsResponse>(
              future: ticketBloc.getHistory(),
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
                          (ticket.ticketTitle
                              .toLowerCase()
                              .contains(searchData.data.toLowerCase()) ||
                              ticket.ticketId
                                  .toString()
                                  .contains(searchData.data))
                              && ticket.ticketStatusId != 1)
                              .toList(),
                          type: 'history',
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

