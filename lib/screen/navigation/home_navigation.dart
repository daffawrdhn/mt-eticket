import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/summary/summary_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/summary/summary_response.dart';
import 'package:mt/resource/values/values.dart';

import 'package:mt/widget/reuseable/card/card_status.dart';
import 'package:mt/widget/reuseable/card/card_status2.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';
import 'package:mt/widget/reuseable/dialog/dialog_error.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeNav extends StatefulWidget {
  final Function onChangeIndex; // Declare the callback function as a parameter

  const HomeNav({Key key, this.onChangeIndex}) : super(key: key);

  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {

  Map<String, double> dataMap;
  int total = 0;

  _fetchSummary() async {
    SummaryResponse response = await summaryBloc.get();
    // Ensure that employeeIds are unique
    setState(() {
      dataMap = {
        "New": response.results.data.open.toDouble(),
        "AP1": response.results.data.ap1.toDouble(),
        "AP2": response.results.data.ap2.toDouble(),
        "AP3": response.results.data.ap3.toDouble(),
        "Approved": response.results.data.approved.toDouble(),
        "Reject": response.results.data.rejected.toDouble(),
        "On Progress": response.results.data.onprogress.toDouble(),
        "Completed": response.results.data.completed.toDouble(),
      };
    });
  }

  final colorList = <Color>[
    Colors.blue[100], //new
    Colors.blue[300], //ap1
    Colors.blue[600], //ap2
    Colors.yellow[400], //ap3
    Colors.yellow[600], //approved
    Colors.grey[500], //reject
    Colors.green[200], //progress
    Colors.green[600] //completed
  ];

  @override
  void initState() {
    super.initState();
    summaryBloc.resetResponse();
    AppData().count = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          _fetchSummary();
        },
        child: Scrollbar(
          thickness: 5.0,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10.0),
              CustomCard(
                leading: Icon(Icons.search),
                title: 'Tickets',
                subtitle: 'Check your ticket status here.',
                textbutton: 'Check',
                action: 1,
                go: (index) {
                  widget.onChangeIndex(index);
                },
              ),
              SizedBox(height: 10.0),
              CustomCard(
                custom: true,
                leading: Icon(Icons.approval),
                title: 'Approval',
                subtitle: 'Ticket dont aproved by itself, check here.',
                textbutton: 'Approve',
                action: 2,
                go: (index) {
                  widget.onChangeIndex(index);
                },
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Ticket Summary',
                  style: TextStyle(
                    fontSize: 36,
                    color: AppColors.loginSubmit,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder(
                future: dataMap == null ? _fetchSummary() : null ,
                builder: (context, summary) {
                  if (summary.hasData || dataMap != null) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: PieChart(
                        emptyColor: AppColors.loginSubmit.withOpacity(0.2),
                        chartValuesOptions: ChartValuesOptions(
                          decimalPlaces: 0,
                        ),
                        dataMap: dataMap,
                        colorList: colorList,),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              SizedBox(height: 10.0),

              eResponse(),
            ],
          ),
        )
      ),
    );
  }
}
