import 'package:flutter/material.dart';

class ExpandableCard extends StatefulWidget {
  final String title;
  final List<String> textList;

  ExpandableCard({
    @required this.title,
    @required this.textList,
  });

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: _isExpanded ? const EdgeInsets.symmetric(vertical: 16.0) : const EdgeInsets.symmetric(vertical: 1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
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
                    color: Colors.blue,
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
