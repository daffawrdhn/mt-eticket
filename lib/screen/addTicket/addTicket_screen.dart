import 'package:flutter/material.dart';

class AddTicketScreen extends StatefulWidget {

  @override
  _AddTicketScreenState createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {

  String _selectedFeature = 'Language Models';
  List<String> _subfeatures = ['GPT-3', 'DALL-E', 'GPT-2'];

  @override
  void initState() {
    super.initState();
    // postBloc.get();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Add New Ticket"),
        ),
        // drawer: DrawerWidget(user: _user.data,),
        body: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButton<String>(
                value: _selectedFeature,
                onChanged: (String newValue) {
                  setState(() {
                    _selectedFeature = newValue;
                    if (newValue == 'Language Models') {
                      _subfeatures = ['GPT-3', 'DALL-E', 'GPT-2'];
                    } else if (newValue == 'Computer Vision') {
                      _subfeatures = ['DALL-E', 'DALL-E 2', 'Image GPT'];
                    } else if (newValue == 'Reinforcement Learning') {
                      _subfeatures = ['AlphaGo', 'OpenAI Gym', 'MuJoCo'];
                    }
                  });
                },
                items: <String>['Language Models', 'Computer Vision', 'Reinforcement Learning']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text('Selected Feature: $_selectedFeature'),
              SizedBox(height: 20),
              Text('Subfeatures:'),
              SizedBox(height: 10),
              Column(
                children: _subfeatures
                    .map((subfeature) => Text(subfeature))
                    .toList(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Future.microtask(() => Navigator.pushNamed(context, '/change'));
          },
          tooltip: 'Add Post',
          child: Icon(Icons.send),
        ),
      );
  }
}