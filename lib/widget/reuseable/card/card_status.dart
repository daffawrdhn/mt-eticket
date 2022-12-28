
import 'package:flutter/material.dart';
import 'package:mt/resource/values/values.dart';

class CustomCard extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  CustomCard({
    this.leading,
    this.title,
    this.subtitle,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).appBarTheme.color,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: leading,
            title: Text(title),
            subtitle: Text(subtitle),
          ),
          ButtonBar(
            children: actions,
          ),
        ],
      ),
    );
  }
}