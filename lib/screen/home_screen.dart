import 'package:flutter/material.dart';
import 'package:mt/bloc/home/logout_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/modelJson/login/login_model.dart';
import 'package:mt/resource/values/values.dart';
import 'package:mt/screen/navigation/approval_navigation.dart';
import 'package:mt/screen/navigation/home_navigation.dart';
import 'package:mt/screen/navigation/profile_navigation.dart';
import 'package:mt/screen/navigation/tickets_navigation.dart';
import 'package:mt/widget/reuseable/drawer/drawer.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Login _user;
  int _selectedIndex = 0;

  String _appBarTitle = 'Home';  // Add this line

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
          _appBarTitle = 'Profile';
          break;
      }
    }
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
      ProfileNav(user: _user),
    ];

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitle),
          actions: <Widget>[
            Visibility(
                visible: _appBarTitle == 'Approval',
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
            )
          ],
        ),
        // drawer: DrawerWidget(user: _user.data,),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              title: Text('Tickets'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check),
              title: Text('Approval'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
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
                  _appBarTitle = 'Profile';
                  break;
              }
            }
          }
          ),
        floatingActionButton: Visibility(visible: _selectedIndex == 1,
          child: FloatingActionButton(
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
            FlatButton(
              child: Text('Yes'),
              onPressed: () async {
                await doLogout();
                Navigator.pop(c, true);
              },
            ),
            FlatButton(
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

