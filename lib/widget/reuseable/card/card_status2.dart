
import 'package:flutter/material.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/resource/values/values.dart';
import 'package:mt/screen/navigation/home_navigation.dart';

class CustomCard2 extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final String textbutton1;
  final String textbutton2;
  final String textbutton3;
  final int action1;
  final int action2;
  final int action3;
  final Function go;
  final bool custom;// Declare the callback function as a parameter

  CustomCard2({
    @required this.leading,
    @required this.title,
    @required this.subtitle,
    @required this.textbutton1,
    @required this.textbutton2,
    @required this.textbutton3,
    @required this.action1,
    @required this.action2,
    @required this.action3,
    @required this.go,
    this.custom
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: leading,
            title: Text(title),
            subtitle: Text(subtitle),
            // trailing: leading,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {
                  go(action1);
                },
                child: Text(textbutton1, style: TextStyle(color: AppColors.loginSubmit),),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.loginSubmit),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  go(action2);
                },
                child: Text(textbutton2, style: TextStyle(color: AppColors.loginSubmit),),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.loginSubmit),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  go(action3);
                },
                child: Text(textbutton3, style: TextStyle(color: AppColors.loginSubmit),),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.loginSubmit),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}