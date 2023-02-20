import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onTap;

  Button({
    @required this.icon,
    @required this.label,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}