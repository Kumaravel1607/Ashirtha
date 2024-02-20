import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/LoginPage.dart';
import 'Screens/OnGoingProjects.dart';
import 'Screens/ProjectUpdates.dart';
import 'Screens/SplashScreen.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new MyApp(),
        routes: <String, WidgetBuilder>{
          "/ProjectUpdates": (BuildContext context) => new ProjectUpdatesPage(),
        }),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences sharedPreferences;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    getMessage();
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final String pagechooser = message['data']['status'];
    Navigator.pushNamed(context, pagechooser);
  }

  Future<void> getMessage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      if (sharedPreferences.getString("user_id") != null) {
        _navigateToItemDetail(message);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProjectUpdatesPage(projectID: message['data']['id']),
            ));
      }
    }, onLaunch: (Map<String, dynamic> message) async {
      print('onMessage: $message');
      if (sharedPreferences.getString("user_id") != null) {
        _navigateToItemDetail(message);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProjectUpdatesPage(projectID: message['data']['id']),
            ));
      }
    }, onResume: (Map<String, dynamic> message) async {
      print('onMessage: $message');
      if (sharedPreferences.getString("user_id") != null) {
        _navigateToItemDetail(message);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProjectUpdatesPage(projectID: message['data']['id']),
            ));
      }
    });

    _firebaseMessaging.getToken().then((token) {
      print("nandhu");
      print(token);
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat'),
      title: 'ASRITHA',
      home: SplashScreen(),
      //  routes: <String,WidgetBuilder>{
      //   "/ProjectUpdates":(BuildContext context)=> new ProjectUpdatesPage(),
      //   }
    );
  }
}
