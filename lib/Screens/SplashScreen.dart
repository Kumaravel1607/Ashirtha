import 'package:asritha/Constant/Colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage.dart';
import 'HomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => checkLoginStatus(),
    );
  }


  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("user_id") != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: white,
          image: DecorationImage(image: AssetImage('assets/images/splash.jpg'), fit: BoxFit.cover)
          // gradient: new LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //       colors: [
          //          appcolor,
          //         appcolor2,
          //       ],
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Image.asset(
              "assets/images/logo.png",
              height: 266,
              width: 266,
            ),
          ],
        ),
      ),
    );
  }
}
