import 'package:flutter/material.dart';
import 'package:mt/bloc/home/logout_bloc.dart';
import 'package:mt/resource/values/values.dart';
class DrawerWidget extends StatelessWidget {
  final user;

  const DrawerWidget({key, this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(user),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
            child: Text("Menu",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                )),
          ),
          _drawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () => Navigator.pushReplacementNamed(context, '/home')
          ),
          Divider(height: 25, thickness: 1),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
            child: Text("Auth",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                )),
          ),
          _drawerItem(
              icon: Icons.logout,
              text: 'Logout',
              // onTap: () async {
              //   await logoutBloc.logout();
              //   Future.microtask(() => Navigator.pushReplacementNamed(context, '/login'));
              // }
              onTap: () => doLogout(context)
          ),
        ],
      ),
    );
  }

  void doLogout(context) async {
    await logoutBloc.logout();
    Future.microtask(() => Navigator.pushReplacementNamed(context, '/login'));
  }

}

Widget _drawerHeader(user) {
  return UserAccountsDrawerHeader(
    currentAccountPicture: ClipOval(
      child: Image(
          image: AssetImage(ImagePath.profile), fit: BoxFit.cover),
    ),
    accountName: Text(user.employeeName + ' - ' +user.organization.orgainzationName),
    accountEmail: Text(user.employeeEmail),
  );
}
Widget _drawerItem({IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}