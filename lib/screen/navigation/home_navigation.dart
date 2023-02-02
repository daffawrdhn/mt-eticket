import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/summary/summary_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/summary/summary_response.dart';
import 'package:mt/resource/values/values.dart';

import 'package:mt/widget/reuseable/card/card_status.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeNav extends StatefulWidget {
  final Function onChangeIndex; // Declare the callback function as a parameter

  const HomeNav({Key key, this.onChangeIndex}) : super(key: key);

  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {

  Map<String, double> dataMap;

  _fetchSummary() async {
    SummaryResponse response = await summaryBloc.get();
    // Ensure that employeeIds are unique
    setState(() {
      dataMap = {
        "New": response.results.data.open.toDouble(),
        "AP1": response.results.data.ap1.toDouble(),
        "AP2": response.results.data.ap2.toDouble(),
        "AP3": response.results.data.ap3.toDouble(),
        "Complete": response.results.data.completed.toDouble(),
        "Reject": response.results.data.rejected.toDouble(),
      };
    });
  }

  final colorList = <Color>[
    Colors.blue, //Open
    Colors.yellow, //AP1
    Colors.orange, //AP2
    Colors.red, //AP3
    Colors.green, //complete
    Colors.grey //reject
  ];

  @override
  void initState() {
    super.initState();
    summaryBloc.resetResponse();
    AppData().count = 1;
  }

  void popupDialogAlert(BuildContext context, String message) {
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
            WidgetsBinding.instance.addPostFrameCallback(
                    (_) => popupDialogAlert(context, snapshot.data));
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 15.0),
            CustomCard(
              leading: Icon(Icons.search),
              title: 'Tickets',
              subtitle: 'Check your ticket status here.',
              actions: <Widget>[
                OutlineButton(
                  child: Text('CHECK'),
                  onPressed: () {
                    widget.onChangeIndex(1);
                  },
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            CustomCard(
              leading: Icon(Icons.approval),
              title: 'Approval',
              subtitle: 'Ticket dont aproved by itself, check here.',
              actions: <Widget>[
                OutlineButton(
                  child: Text('APPROVE'),
                  onPressed: () {
                    widget.onChangeIndex(2);
                  },
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ],
            ),
            SizedBox(height: 10.0),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Ticket Summary',
                style: TextStyle(
                    fontSize: 36,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FutureBuilder(
                  future: dataMap == null ? _fetchSummary() : null ,
                  builder: (context, summary) {
                    if (summary.hasData || dataMap != null) {
                      return PieChart(
                          chartValuesOptions: ChartValuesOptions(
                            decimalPlaces: 0,
                          ),
                          dataMap: dataMap,
                          colorList: colorList,);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                    },
            ),

            SizedBox(height: 10.0),

            errResponse(),
          ],
        ),
      ),
    );
  }
}
