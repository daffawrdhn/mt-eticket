import 'package:flutter/material.dart';
import 'package:mt/widget/reuseable/card/card_status.dart';
import 'package:mt/screen/home_screen.dart';

class HomeNav extends StatelessWidget {
  final Function onChangeIndex; // Declare the callback function as a parameter

  const HomeNav({Key key, this.onChangeIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
        children: <Widget>[
          SizedBox(height: 30.0),
          CustomCard(
            leading: Icon(Icons.search),
            title: 'Tickets',
            subtitle: 'Check your ticket status here.',
            actions: <Widget>[
              FlatButton(
                child: Text('CHECK'),
                onPressed: () {
                  onChangeIndex(1);
                },
              ),
            ],
          ),
          SizedBox(height: 10.0),
          CustomCard(
            leading: Icon(Icons.approval),
            title: 'Approval',
            subtitle: 'Ticket dont aproved by itself, check here.',
            actions: <Widget>[
              FlatButton(
                child: Text('APPROVE'),
                onPressed: () {
                  onChangeIndex(2);
                },
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}
