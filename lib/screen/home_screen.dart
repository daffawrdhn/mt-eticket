import 'package:flutter/material.dart';
import 'package:mt/bloc/home/logout_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/modelJson/login/login_model.dart';
import 'package:mt/resource/values/values.dart';
import 'package:mt/screen/navigation/approval_navigation.dart';
import 'package:mt/screen/navigation/home_navigation.dart';
import 'package:mt/screen/navigation/profile_navigation.dart';
import 'package:mt/screen/navigation/tickets_navigation.dart';
import 'package:mt/screen/navigation/todo_navigation.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Login _user;
  int _selectedIndex = 0;

  String _appBarTitle = 'Home';  // Add this line

  final colorList = <Color>[
    Colors.blue[100], //new
    Colors.blue[300], //ap1
    Colors.blue[600], //ap2
    Colors.yellow[400], //ap3
    Colors.yellow[600], //approved
    Colors.grey[500], //reject
    Colors.green[200], //progress
    Colors.green[600] //completed
  ];

  void _changeIndex(int index) {
    if(_selectedIndex == index) {
    } else {
      setState(() {
        _selectedIndex = index;
      });
      switch (index) {
        case 0:
          _appBarTitle = 'Home';
          break;
        case 1:
          _appBarTitle = 'Tickets';
          break;
        case 2:
          _appBarTitle = 'Approval';
          break;
        case 3:
          _appBarTitle = 'Todo';
          break;
        case 4:
          _appBarTitle = 'Profile';
          break;
      }
    }
  }

  void _info(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ticket Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.sticky_note_2_outlined,
                  color: colorList[0],
                ),
                title: Text("Open"),
              ),
              ListTile(
                leading: Icon(
                  Icons.looks_one,
                  color: colorList[1],
                ),
                title: Text("Approval 1"),
              ),
              ListTile(
                leading: Icon(
                  Icons.looks_two,
                  color: colorList[2],
                ),
                title: Text("Approval 2"),
              ),
              ListTile(
                leading: Icon(
                  Icons.looks_3,
                  color: colorList[3],
                ),
                title: Text("Approval 3"),
              ),
              ListTile(
                leading: Icon(
                  Icons.sticky_note_2_rounded,
                  color: colorList[4],
                ),
                title: Text("Approved"),
              ),
              ListTile(
                leading: Icon(
                  Icons.sticky_note_2_rounded,
                  color: colorList[5],
                ),
                title: Text("Rejected"),
              ),ListTile(
                leading: Icon(
                  Icons.timelapse,
                  color: colorList[6],
                ),
                title: Text("On progress"),
              ),ListTile(
                leading: Icon(
                  Icons.done,
                  color: colorList[7],
                ),
                title: Text("Completed"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _spv(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Supervisor"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: AssetImage(ImagePath.logo_h),
                height: 100,
              ),
              ListTile(
                leading: Icon(
                  Icons.label,
                ),
                title: Text(AppData().user.data.supervisorId),
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                ),
                title: Text(AppData().user.data.supervisorName),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _user = appData.user;
    // postBloc.get();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _widgetOptions = <Widget>[
      HomeNav(onChangeIndex: _changeIndex),
      TicketsNav(),
      ApprovalNav(),
      TodoNav(),
      ProfileNav(user: _user),
    ];

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.loginSubmit,
          title: Text(_appBarTitle),
          actions: <Widget>[
            Visibility(
              visible: _selectedIndex == 0,
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {
                    // do something when button is pressed
                    Future.microtask(() => _info(context));
                  },
                ),
              ),
            ),
            Visibility(
                visible: _selectedIndex == 2,
                child: Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: IconButton(
                      icon: Icon(Icons.history),
                      onPressed: () {
                        // do something when button is pressed
                        Future.microtask(() => Navigator.pushNamed(context, '/history'));
                      },
                    ),
                ),
            ),
            Visibility(
              visible: _selectedIndex == 3,
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Icon(Icons.history),
                  onPressed: () {
                    // do something when button is pressed
                    Future.microtask(() => Navigator.pushNamed(context, '/todohistory'));
                  },
                ),
              ),
            ),
            Visibility(
              visible: _selectedIndex == 4,
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Icon(Icons.supervisor_account),
                  onPressed: () {
                    // do something when button is pressed
                    Future.microtask(() => _spv(context));
                  },
                ),
              ),
            ),
          ],
        ),
        // drawer: DrawerWidget(user: _user.data,),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(0.1)),
            ]
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.note),
                label: 'Tickets',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check),
                label: 'Approval',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wysiwyg),
                label: 'Todo',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.loginSubmit,
            onTap: (int index) {
              if (_selectedIndex == index) {

              } else {
                setState(() {
                  _selectedIndex = index;
                });
                switch (index) {
                  case 0:
                    _appBarTitle = 'Home';
                    break;
                  case 1:
                    _appBarTitle = 'Tickets';
                    break;
                  case 2:
                    _appBarTitle = 'Approval';
                    break;
                  case 3:
                    _appBarTitle = 'Todo';
                    break;
                  case 4:
                    _appBarTitle = 'Profile';
                    break;
                }
              }
            }
            ),
        ),
        floatingActionButton: Visibility(visible: _selectedIndex != 0,
          child: FloatingActionButton(
            backgroundColor: AppColors.loginSubmit,
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
            tooltip: 'Add Post',
            child: Icon(Icons.add),
          ),),
      ),
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('Warning'),
          content: Text('Do you really want to exit'),
          actions: [
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                doLogout();
                Navigator.pop(c, true);
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(c, false),
            ),
          ],
        ),
      ),
    );
  }

  void doLogout() async {
    await logoutBloc.logout();
    Future.microtask(() => Navigator.pushReplacementNamed(context, '/login'));
  }
}

