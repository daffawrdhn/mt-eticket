import 'package:flutter/material.dart';
import 'package:mt/data/sharedpref/preferences.dart';
import 'package:mt/resource/values/values.dart';
import 'package:package_info/package_info.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  bool isLogin = false;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  startTimeout() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  void _isLogin(){
    Prefs.isLogin.then((value) {
      isLogin = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    startTimeout();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
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
                        _packageInfo.version,
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