import 'package:flutter/material.dart';
import 'package:mt/bloc/home/logout_bloc.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/model/modelJson/login/login_model.dart';
import 'package:mt/resource/values/values.dart';
import 'package:mt/screen/navigation/home_navigation.dart';
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

  void _onItemTapped(int index) {
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

  @override
  Widget build(BuildContext context) {

    List<Widget> _widgetOptions = <Widget>[
      HomeNav(onChangeIndex: _changeIndex),
      Text('Index 1: Tickets'),
      Text('Index 2: Approval'),
      Text('Index 3: Profile'),
    ];

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitle),
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
          }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Future.microtask(() => Navigator.pushNamed(context, '/add'));
          },
          tooltip: 'Add Post',
          child: Icon(Icons.add),
        ),
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

