import 'package:flutter/material.dart';
import 'package:mt/resource/values/values.dart';

class CustomCard extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final String textbutton;
  final int action;
  final Function go;
  final bool custom; // Declare the callback function as a parameter

  CustomCard(
      {@required this.leading,
      @required this.title,
      @required this.subtitle,
      @required this.textbutton,
      @required this.action,
      @required this.go,
      this.custom});

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
          ),
          ButtonBar(
            children: [
              OutlinedButton(
                onPressed: () {
                  go(action);
                },
                child: Text(
                  textbutton,
                  style: TextStyle(color: AppColors.loginSubmit),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.loginSubmit),
                ),
              ),
              Visibility(visible: custom == true,
                child: OutlinedButton(
                  onPressed: () {
                    go(3);
                  },
                  child: Text('Todo', style: TextStyle(color: AppColors.loginSubmit),),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.loginSubmit),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
