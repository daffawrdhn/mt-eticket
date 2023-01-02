import 'package:flutter/material.dart';
import 'package:mt/bloc/home/logout_bloc.dart';
import 'package:mt/model/modelJson/login/login_model.dart';
import 'package:mt/resource/values/values.dart';

class ProfileNav extends StatelessWidget {

  final Login user;

  const ProfileNav({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 10.0),
        Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child : Card(
              elevation: 3.0,
              child: Column(
                children: [
                  Center(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 0, top: 0, bottom: 0),
                          width: 100,
                          height: 100,
                          child: Center(
                            child: CircleAvatar(
                              radius: 100,
                              backgroundImage: AssetImage(ImagePath.profile),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name:               '+ user.data.employeeName),
                            Text('Employee ID:    '+ user.data.employeeId),
                            Text('Email:                '+ user.data.employeeEmail),
                            Text('Division:            '+ user.data.organization.orgainzationName),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            color: Colors.grey,
            height: 10,
          ),
        ),
        ListTile(
          leading: Icon(Icons.lock),
          title: Text("Ganti Password"),
          onTap: () {
            // Ganti Password action
            doChange(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text("Logout"),
          onTap: () {
            // Logout action
            doLogout(context);
          },
        ),
      ],
    );
  }

  void doLogout(BuildContext context) async {
    await logoutBloc.logout();
    Future.microtask(() => Navigator.pushReplacementNamed(context, '/login'));
  }

  void doChange(BuildContext context) {
    Future.microtask(() => Navigator.pushNamed(context, '/change'));
  }
}
