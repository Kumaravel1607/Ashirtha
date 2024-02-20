import 'package:asritha/Constant/Colors.dart';
import 'package:asritha/Screens/HomePage.dart';
import 'package:asritha/Screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ContactUsPage.dart';
import 'ProjectListPage.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  SharedPreferences sharedPreferences;

  checkLogoutStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    sharedPreferences.commit();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        (Route<dynamic> route) => false);
  }

   @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: white,
       body: Column(
         children: [
           Container(
            padding: EdgeInsets.all(20),
             height: 150,
             color: appcolor,
             child: Row(
               children: [
                 Image.asset("assets/images/app_logo.png", height: 100,width: 100,),
                 Spacer(),
                 IconButton(icon: Icon(Icons.close, color: white, size: 35,),
                  onPressed: (){
                    Navigator.pop(context);
                 })
               ],
             ),
           ),
           Container(
             padding: EdgeInsets.all(20),
             child: Column(children: [
               ListTile(
                    title: Text(
                      "Home",
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    leading: Icon(Icons.home, color:appcolor),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePage()));
                    },
                  ),
                Divider(
                color: Colors.grey,
                height: 1,
                thickness: 0.5,
              ),
              ListTile(
                    title: Text(
                      "Ongoing Projects",
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    leading: Icon(Icons.stacked_line_chart, color:appcolor),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProjectListPage(projectID: 1)));
                    },
                  ),
                Divider(
                color: Colors.grey,
                height: 1,
                thickness: 0.5,
              ),
              ListTile(
                    title: Text(
                      "Project Updates",
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    leading: Icon(Icons.update_sharp, color:appcolor),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProjectListPage(projectID: 2)));
                    },
                  ),
                Divider(
                color: Colors.grey,
                height: 1,
                thickness: 0.5,
              ),
              ListTile(
                    title: Text(
                      "Contact Us",
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    leading: Icon(Icons.call, color:appcolor),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ContactUsPage()));
                    },
                  ),
                Divider(
                color: Colors.grey,
                height: 1,
                thickness: 0.5,
              ),
              //  ListTile(
              //       title: Text(
              //         "Logout",
              //         style: TextStyle(
              //             fontSize: 14,
              //             color: black,
              //             fontWeight: FontWeight.w500),
              //       ),
              //       leading: Icon(Icons.logout, color:appcolor),
              //       onTap: () {
              //         // checkLogoutStatus();
              //          Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (BuildContext context) =>
              //                     GalleryExample()));
              //       },
              //     ),
              //   Divider(
              //   color: Colors.grey,
              //   height: 1,
              //   thickness: 0.5,
              // ),
             ],)
           )
         ],),
    );
  }
}