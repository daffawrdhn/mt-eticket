import 'package:flutter/material.dart';
import 'package:mt/bloc/home/logout_bloc.dart';
import 'package:mt/resource/values/values.dart';
import 'package:mt/widget/reuseable/dialog/dialog_alert.dart';
import 'package:mt/widget/reuseable/dialog/dialog_profile.dart';
class DrawerWidget extends StatelessWidget {
  final user;

  const DrawerWidget({key, this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(context, user),
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

Widget _drawerHeader(context, user) {
  return UserAccountsDrawerHeader(
    currentAccountPicture: ClipOval(
      child: Image(
          image: AssetImage(ImagePath.profile), fit: BoxFit.cover),
    ),
    accountName: Text(user.employeeName),
    accountEmail: Text(user.employeeEmail),
    onDetailsPressed: () {
      WidgetsBinding.instance.addPostFrameCallback((_) => _popupDialogAlert(context, user));
    },
  );
}

_popupDialogAlert(BuildContext context, user){
  showProfileDialog(
    context: context,
    name: user == 'null' ? "" : user.employeeName,
    email: user == 'null' ? "" : user.employeeEmail,
    organization: user == 'null' ? "" : user.organization.orgainzationName,
    regional: user == 'null' ? "" : user.regional.regionalName,
    icon: Icons.account_circle,
    type: 'success',
    onOk: (){
      Navigator.of(context).pop();
    },
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