import 'package:flutter/material.dart';

class textDetailed extends StatelessWidget {
  final String label;
  final String text;

  const textDetailed({
    Key key,
    @required this.label,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        disabledBorder: InputBorder.none,
        border: InputBorder.none,
      ),
      child: Text(text, style: TextStyle(fontSize: 16.0)),
    );
  }
}
