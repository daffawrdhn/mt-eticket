import 'package:flutter/material.dart';

class textDetail2 extends StatelessWidget {
  final String label;
  final String initialValue;
  final bool isEnable;

  const textDetail2({
    Key key,
    @required this.label,
    @required this.initialValue,
    this.isEnable = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnable,
      initialValue: initialValue,
      maxLines: 2,
      decoration: InputDecoration(
        disabledBorder: InputBorder.none,
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}
