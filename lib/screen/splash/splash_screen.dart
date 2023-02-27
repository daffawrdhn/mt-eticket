import 'package:flutter/material.dart';
import 'package:mt/data/local/app_data.dart';
import 'package:mt/resource/values/values.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  bool isLogin = false;

  startTimeout() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }


  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.35,
                  left: 50,
                  right: 50,
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(ImagePath.logo_h),
                        height: 200,
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 20,
                    left: MediaQuery.of(context).size.width * 0.45,
                    right: 140,
                    child: Text(
                        AppData().version,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15
                        )
                    )
                ),
              ],
            )
        )
    );
  }
}