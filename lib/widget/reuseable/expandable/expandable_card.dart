import 'package:flutter/material.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/resource/values/values.dart';

class ExpandableCard extends StatefulWidget {
  final String title;
  final bool titleBold;
  final Icon icon;
  final List<String> textList;

  ExpandableCard({
    @required this.title,
    @required this.icon,
    this.titleBold,
    @required this.textList,
  });

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _isExpanded = false;

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
      child: Padding(
        padding: _isExpanded ? const EdgeInsets.symmetric(vertical: 16.0) : const EdgeInsets.symmetric(vertical: 1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: widget.icon,
              title: Text(
                widget.title,
                style: TextStyle(
                  fontWeight: widget.titleBold == true ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              trailing: IconButton(
                icon: _isExpanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ),
            Visibility(visible: _isExpanded == true,child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    color: AppColors.loginSubmit,
                    height: 10,
                    thickness: 1.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            ),

            if (_isExpanded)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.textList.map((text) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(text),
                ),
                ).toList(),
              )
          ],
        ),
      ),
    );
  }
}
