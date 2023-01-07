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

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(

            elevation: 3.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(ImagePath.profile),
                        )
                    ),
                  ),
                ),

                Text(user.data.employeeId, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 5.0),
                Text(user.data.employeeName, style: TextStyle(fontSize: 16.0)),
                SizedBox(height: 5.0),
                Text(user.data.employeeEmail, style: TextStyle(fontSize: 16.0)),
                SizedBox(height: 5.0),
                Text(user.data.organization.organizationName, style: TextStyle(fontSize: 16.0)),
                SizedBox(height: 10.0),

              ],
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
