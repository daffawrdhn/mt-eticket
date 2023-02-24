import 'package:flutter/material.dart';
import 'package:mt/bloc/error/error_bloc.dart';
import 'package:mt/bloc/home/logout_bloc.dart';

class reloginButton extends StatelessWidget {
  reloginButton();

  @override
  Widget build(BuildContext context) {
    errorBloc.updateErrMsg('Please relogin app');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Token is invalid'),
        ElevatedButton(
          onPressed: () async {
            await logoutBloc.logout();
            Future.microtask(() => Navigator.pushReplacementNamed(context, '/login'));
          },
          child: Text('Login'),
        ),
      ],
    );
  }
}
